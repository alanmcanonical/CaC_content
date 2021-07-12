#!/usr/bin/env python3

import fileinput
import subprocess
import sys

from collections import namedtuple


# Policy helpers
def load_diff(path):
    cmd = ['git', 'diff', '--cached', path]
    stdout = subprocess.check_output(cmd, stderr=subprocess.STDOUT, encoding='utf-8')
    output = stdout.split("\n")
    return output


def modified_prodtype(path):
    seen_ats = False
    for line in load_diff(path):
        seen_ats = seen_ats or line.startswith('@@')
        if not seen_ats:
            continue
        if line.startswith('-prodtype:') or line.startswith("+prodtype:"):
            return True
    return False


def modified_ref(path, ref):
    seen_ats = False
    for line in load_diff(path):
        seen_ats = seen_ats or line.startswith('@@')
        if not seen_ats:
            continue
        if (line.startswith('-') or line.startswith("+")) and ref in line:
            return True
    return False


def modified_cis(path):
    return modified_ref(path, 'cis@ubuntu')


def modified_stigid(path):
    return modified_ref(path, 'stigid@ubuntu')


StatusLine = namedtuple("StatusLine", ["src_mode", "dst_mode", "src_hash", "dst_hash", "status", "score"])
OnlyOnePolicy = namedtuple("OnlyOnePolicy", ["status", "top_dir", "basename", "parent_dir", "message"])
OnlyTypePolicy = namedtuple("OnlyOnePolicy", ["status", "top_dir", "basename", "parent_dir", "diff_helper", "message"])
CatchAllPolicy = namedtuple("CatchAllPolicy", ["status", "top_dir", "basename", "parent_dir", "message"])

# Changes which conflict with any other change of the same or different types.
OnlyOnePolicies = [
    # status, top_dir, basename, parent_dir, message
    # Fields can be left as None to not match or be a list to match multiple items.
    OnlyOnePolicy('A', 'linux_os', 'rule.yml', None, "Any new rules should be committed separately"),
    OnlyOnePolicy('A', 'linux_os', None, 'bash', "Any new bash hardening should be committed separately"),
    OnlyOnePolicy('A', 'linux_os', None, 'ansible', "Any new Ansible hardening should be committed separately"),
    OnlyOnePolicy('A', 'linux_os', None, 'oval', "Any new OVAL checks should be committed separately"),
    OnlyOnePolicy('A', 'linux_os', None, 'sce', "Any new SCE checks should be committed separately"),
    OnlyOnePolicy(None, 'ubuntu1604', None, 'profiles', "Any profile changes should be committed separately"),
    OnlyOnePolicy(None, 'ubuntu1804', None, 'profiles', "Any profile changes should be committed separately"),
    OnlyOnePolicy(None, 'ubuntu2004', None, 'profiles', "Any profile changes should be committed separately"),
]

# Changes which may affect multiple files but otherwise conflict across other
# types.
OneTypePolicies = [
    # status, top_dir, basename, parent_dir, diff_helper, message
    # Fields can be left as None to not match or be a list to match multiple items.
    OnlyTypePolicy('M', 'linux_os', 'rule.yml', None, modified_prodtype, "Any modified prodtypes should be committed together"),
    OnlyTypePolicy('M', 'linux_os', 'rule.yml', None, modified_cis, "Any modified CIS references should be committed together"),
    OnlyTypePolicy('M', 'linux_os', 'rule.yml', None, modified_stigid, "Any modified STIG references should be committed together"),
]

# Catch-all policies
CatchAllPolicies = [
    # Fields can be left as None to not match or be a list to match multiple items.
    CatchAllPolicy('M', 'linux_os', 'rule.yml', None, "Any modifications to rule.yml should be committed together"),
    CatchAllPolicy('M', 'linux_os', None, 'bash', "Any modifications to bash hardening should be committed together"),
    CatchAllPolicy('M', 'linux_os', None, 'ansible', "Any modifications to Ansible hardening should be committed together"),
    CatchAllPolicy('M', 'linux_os', None, 'oval', "Any modifications to OVAL checks should be committed together"),
    CatchAllPolicy('M', 'linux_os', None, 'sce', "Any modifications to SCE checks should be committed together"),
    CatchAllPolicy(['A', 'M', 'R', 'D'], 'shared', None, None, "Any modifications to shared content should be committed together"),
    CatchAllPolicy(['A', 'M', 'R', 'D'], ['build-scripts', 'cmake', 'ssg', 'utils', 'tests'], None, None, "Any modifications to infrastructure should be committed together"),
    CatchAllPolicy(None, None, None, None, "Any other modifications")
]

def parse_stdin():
    renames = dict()
    difflines = dict()

    for line in fileinput.input():
        # Status information is separated from file paths by tabs.
        portions = line.strip().split("\t")

        # First portion is status information, separated by spaces.
        info = portions[0].split(' ')

        # FIXUP: sometimes status (5th field) contains a numerical score.
        # Separate this out when it exists.
        if len(info[4]) > 1:
            score = int(info[4][1:])
            info[4] = info[4][0]
            info.append(score)
        else:
            info.append(None)

        # Second portion and optional third portions are original and
        # optional final file paths.
        original_path = portions[1]
        final_path = portions[1]
        if len(portions) >= 3:
            final_path = portions[2]

        # Only add the rename (from final->original) if necessary.
        if original_path != final_path:
            renames[final_path] = original_path

        # Store the result indexed by final path.
        difflines[final_path] = StatusLine._make(info)

    return renames, difflines


def validate_renames(renames, difflines):
    for dst in renames:
        src = renames[dst]
        entry = difflines[dst]
        if entry.src_hash != entry.dst_hash:
            print(f"In rename of {src}->{dst}, file was also modified.")
            print("Please commit rename separate from modification.")
            sys.exit(1)


def skip_policy_field(policy_value, entry_value):
    if not policy_value:
        return False
    if isinstance(policy_value, str):
        return entry_value != policy_value
    if isinstance(policy_value, list):
        return entry_value not in policy_value
    return False


def skip_policy(policy, entry, top_dir, basename, parent_dir):
    return (
        skip_policy_field(policy.status, entry.status) or
        skip_policy_field(policy.top_dir, top_dir) or
        skip_policy_field(policy.basename, basename) or
        skip_policy_field(policy.parent_dir, parent_dir)
    )


def validate_policy_context(context, all_policies, this_index, this_path, exclusive=False):
    if -1 in context:
        if context[-1] != this_index:
            print("Files with conflicting policies were committed.\n")
            print(all_policies[context[-1]].message)
            if isinstance(context[context[-1]], str):
                print(f"\tpath: {context[context[-1]]}")
            else:
                for their_path in context[context[-1]]:
                    print(f"\tpath: {their_path}")
            print()
            print(all_policies[this_index].message)
            print(f"\tpath: {this_path}")
            sys.exit(1)
        if context[-1] == this_index and exclusive:
            print("Two files with exclusive policies were committed.")
            print(policy.message)
            print(f"\tpath:{context[this_index]}")
            print(f"\tpath: {this_path}")
            sys.exit(1)

def cross_validate_policy_contexts(left_context, left_policies, right_context, right_policies):
    if -1 in left_context and -1 in right_context:
        print("Files with conflicting policies were committed.\n")
        print(left_policies[left_context[-1]].message)
        left_files = left_context[left_context[-1]]
        if isinstance(left_files, str):
            print(f"\tpath: {left_files}")
        else:
            for left_file in left_files:
                print(f"\tpath: {left_file}")
        print()
        print(right_policies[right_context[-1]].message)
        right_files = right_context[right_context[-1]]
        if isinstance(right_files, str):
            print(f"\tpath: {right_files}")
        else:
            for right_file in right_files:
                print(f"\tpath: {right_file}")

        sys.exit(1)


def validate_only_one_policy(context, path, entry, top_dir, basename, parent_dir):
    matched = False
    for index, policy in enumerate(OnlyOnePolicies):
        if skip_policy(policy, entry, top_dir, basename, parent_dir):
            continue

        validate_policy_context(context, OnlyOnePolicies, index, path, exclusive=True)

        context[-1] = index
        context[index] = path
        matched = True

    return matched


def validate_one_type_policy(context, path, entry, top_dir, basename, parent_dir):
    matched = False
    for index, policy in enumerate(OneTypePolicies):
        if skip_policy(policy, entry, top_dir, basename, parent_dir):
            continue

        if policy.diff_helper is not None:
            if not policy.diff_helper(path):
                continue

        if index not in context:
            context[index] = set()
        context[index].add(path)

        matched = True

        validate_policy_context(context, OneTypePolicies, index, path)
        context[-1] = index

    return matched

def validate_catch_policy(context, path, entry, top_dir, basename, parent_dir):
    # Other policies are checked across each other. For a catch-all policy, we
    # don't validate files against _all_ policies: the first policy that
    # matches "claims" the file. This serves as a last-ditch effort to match
    # changes to the content and build system.
    for index, policy in enumerate(CatchAllPolicies):
        if skip_policy(policy, entry, top_dir, basename, parent_dir):
            continue

        if index not in context:
            context[index] = set()
        context[index].add(path)

        validate_policy_context(context, CatchAllPolicies, index, path)
        context[-1] = index

        return True

    return False

def validate_policy(difflines):
    only_policy_context = dict()
    typed_policy_context = dict()
    catch_all_context = dict()

    all_contexts = [only_policy_context, typed_policy_context, catch_all_context]
    all_policies = [OnlyOnePolicies, OneTypePolicies, CatchAllPolicies]

    for path in difflines:
        entry = difflines[path]
        top_dir = path.split('/')[0]
        basename = path.split('/')[-1]
        parent_dir = top_dir
        if '/' in path:
            parent_dir = path.split('/')[-2]

        match_policy = False
        match_policy |= validate_only_one_policy(only_policy_context, path, entry, top_dir, basename, parent_dir)
        match_policy |= validate_one_type_policy(typed_policy_context, path, entry, top_dir, basename, parent_dir)
        if not match_policy:
            validate_catch_policy(catch_all_context, path, entry, top_dir, basename, parent_dir)

    # Finally validate across policies:
    for left_index, left_context in enumerate(all_contexts):
        left_policy = all_policies[left_index]
        for right_index, right_context in enumerate(all_contexts[left_index+1:]):
            right_policy = all_policies[right_index]
            cross_validate_policy_contexts(left_context, left_policy, right_context, right_policy)

def main():
    renames, difflines = parse_stdin()

    # First enforce the rename policy: renames should occur before any changes
    # to the file itself.
    validate_renames(renames, difflines)

    # Then enforce file policies.
    validate_policy(difflines)

    print("commit OK")

if __name__ == "__main__":
    main()

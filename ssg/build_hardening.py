from __future__ import absolute_import
from __future__ import print_function

import os
import os.path
import json
import textwrap

from .build_yaml import Rule, DocumentationNotComplete
from .constants import MULTI_PLATFORM_LIST
from .jinja import process_file_with_macros
from .rules import get_rule_dir_id, get_rule_dir_sces, find_rule_dirs_in_paths
from . import utils

def ref_to_int(section):
    # Hack: convert nested section number into an integer in the correct
    # order numerically. We use descending powers of 10 to accomplish this
    # magic. Note that we skip every other power in order to support 2-digit
    # section numbers (e.g., 1.10 -> 110 not 20).
    #
    # If it doesn't look like this is a section number, skip it. The latter is
    # another nasty hack for detecting if there are any letters in the section
    # or if we assume they're all numbers. Presumably, all other characters
    # would not be valid section identifiers, else the build will definitely
    # err out here.
    if '.' not in section or section.lower().islower():
        return section

    MAX_DEPTH = 10
    return sum([int(x)*10**((2*MAX_DEPTH)-2*i) for i,x in enumerate(section.split('.'))])

def process_bash_fix(rule_id, fix):
    split_fix = fix.split("\n")

    found_import = False
    removed_import_next_empty_blank_line = False

    cleaned_fix = []
    for line in split_fix:
        if not found_import and line.startswith(". /") and line.endswith("remediation_functions"):
            found_import = True
            removed_import_next_empty_blank_line = False
        elif line.startswith(". /") or line.startswith(". ."):
            assert ("Unexpected second import in remediation", rule_id, fix, line) == False
        elif found_import and not removed_import_next_empty_blank_line:
            removed_import_next_empty_blank_line = True
            if not line:
                cleaned_fix.append(line)
        else:
            cleaned_fix.append(line)

    if cleaned_fix[-1]:
        cleaned_fix.append('')

    joined_fix = "\n".join(cleaned_fix)
    return textwrap.indent(joined_fix, ' ' * 4)

def bash_for_reference(env_yaml, yaml_path, remediation_dir, output, reference, group_by_major_section=True):
    product = utils.required_key(env_yaml, "product")
    included_checks_count = 0
    already_loaded = dict()
    local_env_yaml = dict()
    local_env_yaml.update(env_yaml)

    product_dir = os.path.dirname(yaml_path)
    relative_guide_dir = utils.required_key(env_yaml, "benchmark_root")
    guide_dir = os.path.abspath(os.path.join(product_dir, relative_guide_dir))
    additional_content_directories = env_yaml.get("additional_content_directories", [])
    add_content_dirs = [
        os.path.abspath(os.path.join(product_dir, rd))
        for rd in additional_content_directories
    ]

    rules_by_reference = dict()
    rules_to_fix = dict()
    rule_id_to_parsed = dict()

    # We have two options here: iterate over all rules in the benchmark and
    # then check if we've built a remediation script for it... ...or iterate
    # over the remediation scripts in the directory and handle them as
    # appropriate.
    #
    # We'd need to maintain a mapping (or end up walking all rule dirs
    # anyways) to locate a rule_dir by the rule_id, so for now it is
    # best to ignore the problem and take the performance hit.
    for _dir_path in find_rule_dirs_in_paths([guide_dir] + add_content_dirs):
        rule_id = get_rule_dir_id(_dir_path)

        rule_path = os.path.join(_dir_path, "rule.yml")
        try:
            rule = Rule.from_yaml(rule_path, env_yaml, None)
        except DocumentationNotComplete:
            # Happens on non-debug builds when a rule isn't yet complete. We
            # don't build hardening for this rule and so skip it and move on.
            continue

        rule.normalize(product)

        if 'all' not in rule.prodtype and product not in rule.prodtype:
            continue

        assert rule_id not in rule_id_to_parsed
        rule_id_to_parsed[rule_id] = rule

        if reference not in rule.references:
            continue

        reference_id = rule.references[reference]

        if reference_id not in rules_by_reference:
            rules_by_reference[reference_id] = set()
        rules_by_reference[reference_id].add(rule_id)

        bash_fix = "{0}.sh".format(rule_id)
        rule_remediation = os.path.join(remediation_dir, bash_fix)
        if os.path.exists(rule_remediation):
            rules_to_fix[rule_id] = rule_remediation

    if not rules_by_reference or not rules_to_fix:
        return

    # If the current reference identifier can't easily be ordered by sections,
    # don't attempt to group it by section.
    if not isinstance(ref_to_int(list(rules_by_reference.keys())[0]), int):
        group_by_major_section = False

    # Process found reference numbers into helper functions, one per reference
    # identifier. Each reference identifier may contain multiple rules. Each
    # rule either has a remediation or it doesn't; if it doesn't, print a
    # manual configuration message.
    ref_to_function = dict()
    for reference_id in rules_by_reference:
        func = "rule-{0}()\n".format(reference_id)
        func += "{\n"

        have_banner = False

        for rule_id in sorted(rules_by_reference[reference_id]):
            rule = rule_id_to_parsed[rule_id]
            if have_banner:
                func += '\n\n'
                func += '    banner="{0}"\n'.format(rule.title)
            else:
                func += '    local banner="{0}"\n'.format(rule.title)
                have_banner = True
            func += '    print_rule_banner "${banner}"\n'

            have_remediation = False
            if rule_id in rules_to_fix:
                fix_path = rules_to_fix[rule_id]
                fix = open(fix_path, 'r').read()
                if not fix:
                    print(("Fix isn't present?", fix))
                    continue

                # Indicate that we have a remediation and then include it.
                have_remediation = True
                func += "\n"
                func += process_bash_fix(rule_id, fix)

            if not have_remediation:
                func += '    print_manual_req_msg "${banner}"\n'

        func += "}\n"
        ref_to_function[reference_id] = func

    # Finally, write the resulting remediations out to disk in proper sorted
    # order.
    out_file = None
    last_section = None
    if not group_by_major_section:
        out_filename = "{0}-ruleset.sh".format(reference.upper())
        out_path = os.path.join(output, out_filename)
        out_file = open(out_path, 'w')
        print("#!/bin/bash", end="\n\n", file=out_file)

    for reference_id in sorted(rules_by_reference.keys(), key=ref_to_int):
        if group_by_major_section:
            this_section = reference_id.split('.')[0]
            if last_section != this_section:
                if out_file:
                    out_file.flush()
                    out_file.close()

                out_filename = "{0}-ruleset-{1}.sh".format(reference.upper(), this_section)
                out_path = os.path.join(output, out_filename)
                out_file = open(out_path, 'w')
                print("#!/bin/bash", end="\n\n", file=out_file)
                last_section = this_section

        assert out_file
        print(ref_to_function[reference_id], end="\n\n", file=out_file)

    if out_file:
        out_file.close()


def cis(env_yaml, yaml_path, remediation_dir, output):
    return bash_for_reference(env_yaml, yaml_path, remediation_dir, output, 'cis')

def stig(env_yaml, yaml_path, remediation_dir, output):
    return bash_for_reference(env_yaml, yaml_path, remediation_dir, output, 'stigid', group_by_major_section=False)

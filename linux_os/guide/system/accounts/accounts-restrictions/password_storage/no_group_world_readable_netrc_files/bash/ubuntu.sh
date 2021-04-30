# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

fetch_users_and_homedir |\
while read user dir; do
    chmod -f og-rwx "${dir}/.netrc"
done

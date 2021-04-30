# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

fetch_users_and_homedir |\
while read user dir; do
    chmod o-wrx,g-w "${dir}"
done

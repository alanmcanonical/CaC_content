# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

fetch_users_and_homedir |\
while read user dir; do
    find "$dir" -iname '.*' -type f -execdir chown "$user" {} \;
done

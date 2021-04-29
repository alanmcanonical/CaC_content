# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

fetch_users_and_homedir |\
while read user dir; do
    group_name="$(id --group --name "$user")"
    find "$dir" -iname '.*' -type f -execdir chgrp "$group_name" {} \;
done

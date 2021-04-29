# Return user name and their respective home directory, separated by a single " "
fetch_users_and_homedir()
{
    cat /etc/passwd | egrep -v '^(halt|sync|shutdown)' |\
     awk -F: '($7 != "/usr/sbin/nologin" && $7 != "/bin/false" && $3 >= 1000)\
     { print $1 " " $6 }'
}

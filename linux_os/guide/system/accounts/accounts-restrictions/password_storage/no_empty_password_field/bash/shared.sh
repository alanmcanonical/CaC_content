# platform = multi_platform_all
for usr in $(cat /etc/shadow | awk -F: '($2 == "" ) { print $1 }'); do
    passwd -l ${usr}
done

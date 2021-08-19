#!/bin/bash

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/usr/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }'| while read user dir; do
if [ -d "$dir" ]; then
    find ${dir} -maxdepth 1 -iname '.*' -exec chown ${user} '{}' \;
fi
done

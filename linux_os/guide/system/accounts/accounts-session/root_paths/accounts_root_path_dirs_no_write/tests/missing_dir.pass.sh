#!/bin/bash

new_path_value="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/this/path/does/not/exist:/sbin:/bin"

profile_paths="/etc/skel/.profile /etc/environment /etc/crontab /etc/bash.bashrc /etc/profile /root/.profile /root/.bashrc"
defs_path="/etc/login.defs"

sed -i '/PATH=/d' $profile_paths $defs_path

for profile_path in $profile_paths; do
    if [ -e "$profile_path" ]; then
        echo 'PATH="'"$new_path_value"'"' >> "$profile_path"
    fi
done

echo "ENV_SUPATH	PATH=$new_path_value" >> "$defs_path"
echo "ENV_PATH	PATH=$new_path_value" >> "$defs_path"

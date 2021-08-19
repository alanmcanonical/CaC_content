#!/bin/bash

username="testuser"
homedir=/home/${username}
useradd -m -U ${username}

find /root /home/* -type f -iname '.*' -exec chmod og-w '{}' \;

touch ${homedir}/.group_write
chmod g+w ${homedir}/.group_write

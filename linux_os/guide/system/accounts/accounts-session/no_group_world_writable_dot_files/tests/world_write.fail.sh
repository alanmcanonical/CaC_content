#!/bin/bash

username="testuser"
homedir=/home/${username}
useradd -m -U ${username}

find /root /home/* -type f -iname '.*' -exec chmod og-w '{}' \;

touch ${homedir}/.world_write
chmod o+w ${homedir}/.world_write

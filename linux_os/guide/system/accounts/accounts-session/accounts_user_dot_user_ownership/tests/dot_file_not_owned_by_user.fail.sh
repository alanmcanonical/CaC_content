#!/bin/bash

username="testuser"
homedir=/home/${username}
useradd -m -U ${username}

touch ${homedir}/.wrong_user
chown root ${homedir}/.wrong_user

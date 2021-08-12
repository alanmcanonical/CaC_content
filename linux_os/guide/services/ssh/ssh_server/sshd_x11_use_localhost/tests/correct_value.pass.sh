#!/bin/bash

if grep -q "^X11UseLocalhost" /etc/ssh/sshd_config; then
    sed -i "s/^X11UseLocalhost.*/X11UseLocalhost yes/" /etc/ssh/sshd_config
else
    echo "X11UseLocalhost yes" >> /etc/ssh/sshd_config
fi

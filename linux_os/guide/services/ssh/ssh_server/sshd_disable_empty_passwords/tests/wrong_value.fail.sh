#!/bin/bash

if grep -q '.*PermitEmptyPasswords.*' /etc/ssh/sshd_config; then
    sed -i 's/^.*PermitEmptyPasswords.*$/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
else
    echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
fi

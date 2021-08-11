#!/bin/bash

if grep -q '.*PermitEmptyPasswords.*' /etc/ssh/sshd_config; then
    sed -i 's/^.*PermitEmptyPasswords.*$/PermitEmptyPasswords no/' /etc/ssh/sshd_config
else
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
fi

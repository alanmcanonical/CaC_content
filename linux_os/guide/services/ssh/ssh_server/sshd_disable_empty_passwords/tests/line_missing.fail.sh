#!/bin/bash

if grep -q '.*PermitEmptyPasswords.*' /etc/ssh/sshd_config; then
    sed -i '/^.*PermitEmptyPasswords.*$/d' /etc/ssh/sshd_config
fi

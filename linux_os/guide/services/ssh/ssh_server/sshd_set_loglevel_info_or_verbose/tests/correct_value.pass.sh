#!/bin/bash
SSHD_CONFIG="/etc/ssh/sshd_config"

if grep -qi "^LogLevel" $SSHD_CONFIG; then
	sed -i "s/^LogLevel.*/LogLevel INFO/g" $SSHD_CONFIG
else
	echo "LogLevel INFO" >> $SSHD_CONFIG
fi

#!/bin/bash
SSHD_CONFIG="/etc/ssh/sshd_config"

if grep -qi "^LogLevel" $SSHD_CONFIG; then
	sed -i "s/^LogLevel.*/LogLevel DEBUG/g" $SSHD_CONFIG
else
	echo "LogLevel DEBUG" >> $SSHD_CONFIG
fi

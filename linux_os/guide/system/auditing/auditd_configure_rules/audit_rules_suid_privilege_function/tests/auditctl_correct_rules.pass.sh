#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

# use auditctl
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

rm -rf /etc/audit/rules.d/*
rm /etc/audit/audit.rules


echo "-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -k setuid" >> /etc/audit/audit.rules
echo "-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k setuid" >> /etc/audit/audit.rules
echo "-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -k setgid" >> /etc/audit/audit.rules
echo "-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -k setgid" >> /etc/audit/audit.rules

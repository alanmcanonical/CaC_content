#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo "-a always,exit -F arch=b32 -S {{{ ATTR }}} -F auid>={{{ auid }}} -F auid!=unset -F key=perm_mod" >> /etc/audit/audit.rules
echo "-a always,exit -F arch=b64 -S {{{ ATTR }}} -F auid>={{{ auid }}} -F auid!=unset -F key=perm_mod" >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

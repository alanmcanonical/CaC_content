#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

# use auditctl
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

echo "some value" > /etc/audit/audit.rules

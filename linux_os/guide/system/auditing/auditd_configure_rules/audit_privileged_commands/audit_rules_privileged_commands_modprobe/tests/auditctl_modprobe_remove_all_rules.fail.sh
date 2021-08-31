#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

rm -f /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo '-w {{{ PATH }}} -p wa -k logins' >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

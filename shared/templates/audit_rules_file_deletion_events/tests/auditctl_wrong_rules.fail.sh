#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo '-a always -F arch=$ARCH -S {{{ NAME }}} -F auid>={{{ auid }}} -F auid!=unset -F key=delete' >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

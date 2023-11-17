#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo '-a always -F arch=b32 -S delete_module -F auid>=1000 -F auid!=unset -F key=modules' >> /etc/audit/audit.rules
echo '-a always -F arch=b64 -S delete_module -F auid>=1000 -F auid!=unset -F key=modules' >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

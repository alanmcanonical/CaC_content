#!/bin/bash

echo '-a always -F arch=b32 -S delete_module -F key=modules' >> /etc/audit/audit.rules
echo '-a always -F arch=b64 -S delete_module -F key=modules' >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

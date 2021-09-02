#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

# use auditctl
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

{{% if 'ubuntu' not in product %}}
echo "-w /etc/selinux/ -p wa -k MAC-policy" > /etc/audit/audit.rules
{{% else %}}
echo "-w /etc/apparmor/ -p wa -k MAC-policy" > /etc/audit/audit.rules
echo "-w /etc/apparmor.d/ -p wa -k MAC-policy" >> /etc/audit/audit.rules
{{% endif %}}

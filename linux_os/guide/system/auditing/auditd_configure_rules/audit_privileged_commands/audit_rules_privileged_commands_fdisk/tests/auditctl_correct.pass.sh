#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo "-w /sbin/fdisk -p x -k modules" >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

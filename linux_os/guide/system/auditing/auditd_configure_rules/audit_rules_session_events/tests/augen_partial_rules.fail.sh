#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

rm -rf /etc/audit/rules.d/*
rm -f /etc/audit/audit.rules

echo "-w /var/run/utmp -p wa -k session" >> /etc/audit/audit.rules

#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

mkdir -p /etc/audit/rules.d
echo "-w {{{ PATH }}} -p w -k audit_rules_usergroup_modification" >> /etc/audit/rules.d/login.rules

#!/bin/bash

mkdir -p /etc/audit/rules.d
echo "-w {{{ PATH }}} -p wa -k audit_rules_usergroup_modification" >> /etc/audit/rules.d/login.rules

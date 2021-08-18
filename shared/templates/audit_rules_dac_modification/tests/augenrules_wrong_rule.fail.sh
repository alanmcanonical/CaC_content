#!/bin/bash

mkdir -p /etc/audit/rules.d

echo "-a always -F arch=b32 -S {{{ ATTR }}} -F auid>={{{ auid }}} -F auid!=unset -F key=perm_mod" >> /etc/audit/rules.d/perm_mod.rules
echo "-a always -F arch=b64 -S {{{ ATTR }}} -F auid>={{{ auid }}} -F auid!=unset -F key=perm_mod" >> /etc/audit/rules.d/perm_mod.rules

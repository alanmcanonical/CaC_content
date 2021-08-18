#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo "-a always,exit -F arch=b32 -S {{{ ATTR }}} -F auid>={{{ auid }}} -F auid!=unset -F key=perm_mod" >> /etc/audit/rules.d/perm_mod.rules
echo "-a always,exit -F arch=b64 -S {{{ ATTR }}} -F auid>={{{ auid }}} -F auid!=unset -F key=perm_mod" >> /etc/audit/rules.d/perm_mod.rules

#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo "-w /bin/kmod -p rwx -k modules" > /etc/audit/rules.d/modules.rules
augenrules --load

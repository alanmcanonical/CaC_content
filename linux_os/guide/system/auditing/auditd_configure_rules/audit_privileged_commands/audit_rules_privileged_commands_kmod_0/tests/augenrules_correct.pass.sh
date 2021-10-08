#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo "-w /bin/kmod -p x -k modules" > /etc/audit/rules.d/modules.rules
augenrules --load

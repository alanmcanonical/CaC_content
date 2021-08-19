#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo "-w /usr/bin/kmod -p x -k modules" >> /etc/audit/rules.d/modules.rules

#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo "-w /sbin/something -p x -k modules" >> /etc/audit/rules.d/modules.rules

#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/rules.d/delete.rules

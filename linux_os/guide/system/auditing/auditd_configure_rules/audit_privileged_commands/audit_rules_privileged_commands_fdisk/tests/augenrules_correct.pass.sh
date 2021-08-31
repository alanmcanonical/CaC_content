#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo "-w /sbin/fdisk -p x -k modules" >> /etc/audit/rules.d/modules.rules

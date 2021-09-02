#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}
# platform = multi_platform_ubuntu

echo "-w /etc/apparmor.d/ -p wa -k MAC-policy" > /etc/audit/audit.rules

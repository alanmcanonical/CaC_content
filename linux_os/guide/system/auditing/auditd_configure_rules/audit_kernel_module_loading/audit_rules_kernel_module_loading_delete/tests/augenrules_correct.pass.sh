#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo '-a always,exit -F arch=b32 -S delete_module -F auid>=1000 -F auid!=unset -F key=modules' >> /etc/audit/rules.d/modules.rules
echo '-a always,exit -F arch=b64 -S delete_module -F auid>=1000 -F auid!=unset -F key=modules' >> /etc/audit/rules.d/modules.rules

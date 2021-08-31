#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo '-a always -F arch=$ARCH -S {{{ NAME }}} -F auid>={{{ auid }}} -F auid!=unset -F key=delete' >> /etc/audit/rules.d/delete.rules

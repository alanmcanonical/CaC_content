#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo "-a always -F path={{{ PATH }}} -F auid>={{{ auid }}} -F auid!=unset -F key=privileged" >> /etc/audit/audit.rules

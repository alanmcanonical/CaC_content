#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}
# remediation = none

rm -f /etc/audit/rules.d/*
> /etc/audit/audit.rules
true

#!/bin/bash
# remediation = bash
# packages = {{{ ssgts_package("audit") }}}

rm -f /etc/audit/rules.d/*
> /etc/audit/audit.rules

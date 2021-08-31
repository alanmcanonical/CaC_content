#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

mkdir -p /etc/audit/rules.d
rm -f /etc/audit/rules.d/*
> /etc/audit/audit.rules

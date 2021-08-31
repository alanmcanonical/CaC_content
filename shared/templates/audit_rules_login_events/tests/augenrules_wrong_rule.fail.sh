#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo '-w {{{ PATH }}} -p w -k logins' >> /etc/audit/rules.d/login.rules

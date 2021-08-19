#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

echo '-w {{{ PATH }}} -p wa -k logins' >> /etc/audit/rules.d/login.rules

#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

touch /var/log/audit/audit.log.1
useradd testuser_123
chown testuser_123 /var/log/audit/audit.log.1

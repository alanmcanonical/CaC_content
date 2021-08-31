#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo 'disk_full_action = ignore' > /etc/audit/auditd.conf

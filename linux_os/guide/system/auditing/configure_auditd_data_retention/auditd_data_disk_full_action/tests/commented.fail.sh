#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

echo '# disk_full_action = halt' > /etc/audit/auditd.conf

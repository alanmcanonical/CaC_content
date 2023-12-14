#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

source common.sh

echo "log_group = root" >> /etc/audit/auditd.conf

chgrp group_test ${FILE1}

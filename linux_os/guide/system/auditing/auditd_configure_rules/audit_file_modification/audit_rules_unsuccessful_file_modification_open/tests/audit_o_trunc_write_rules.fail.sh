#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}
# remediation = none

cp $SHARED/audit_open_o_trunc_write.rules /etc/audit/rules.d/

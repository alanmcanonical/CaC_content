#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}
# remediation = none

cp $SHARED/audit_open.rules /etc/audit/rules.d/

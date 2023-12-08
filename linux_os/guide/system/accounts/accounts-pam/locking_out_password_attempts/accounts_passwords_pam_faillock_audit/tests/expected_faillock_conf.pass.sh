#!/bin/bash
# packages = authselect,pam
# platform = Oracle Linux 8,Red Hat Enterprise Linux 8

source common.sh

echo "audit" >> /etc/security/faillock.conf

{{{ bash_pam_faillock_enable() }}}


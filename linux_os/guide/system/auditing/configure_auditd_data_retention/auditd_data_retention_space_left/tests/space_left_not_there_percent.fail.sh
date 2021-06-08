#!/bin/bash
# variables var_auditd_space_left=25%
# remediation = bash

. $SHARED/auditd_utils.sh
prepare_auditd_test_enviroment
delete_parameter /etc/audit/auditd.conf "space_left"

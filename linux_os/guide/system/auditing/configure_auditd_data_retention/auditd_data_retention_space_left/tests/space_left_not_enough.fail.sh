#!/bin/bash
# variables var_auditd_space_left=100
# remediation = bash

. $SHARED/auditd_utils.sh
prepare_auditd_test_enviroment
set_parameters_value /etc/audit/auditd.conf "space_left" "15"

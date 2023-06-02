#!/bin/bash
#
# platform = multi_platform_ubuntu
# check-import = stdout
# check-export = var_firewall_package=fw_choice
#
# "Copyright 2021 Canonical Limited. All rights reserved."
#
#--------------------------------------------------------

# 3.5.1.4 Ensure loopback traffic is configured: ufw_deny_in_other_for_localhost
rule_type="ufw"

# verify if rule type matches the current firewall being audited
if [ "${XCCDF_VALUE_fw_choice}" != "${rule_type}" ]; then
    exit "${XCCDF_RESULT_NOT_APPLICABLE}"
fi

ufw_status=$(ufw status verbose)
if ! grep -q -E "^Anywhere\s+DENY IN\s+127.0.0.0/8" <<< "$ufw_status"; then
    exit "${XCCDF_RESULT_FAIL}"
fi

exit "${XCCDF_RESULT_PASS}"

#!/bin/bash
#
# platform = multi_platform_ubuntu
# check-import = stdout
# check-export = var_firewall_package=fw_choice
#
# "Copyright 2021 Canonical Limited. All rights reserved."
#
#--------------------------------------------------------

# 3.5.1.4 Ensure loopback traffic is configured: ufw_allow_out_lo
rule_type="ufw"

# verify if rule type matches the current firewall being audited
if [ "${XCCDF_VALUE_fw_choice}" != "${rule_type}" ]; then
    exit "${XCCDF_RESULT_NOT_APPLICABLE}"
fi

if [ -e /proc/sys/net/ipv6/conf/all/disable_ipv6 ] && [ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6)" -eq 0 ]; then
    ufw_status=$(ufw status verbose)
    if ! grep -q -E "Anywhere \(v6\)\s+DENY IN\s+::1" <<< "$ufw_status"; then
        exit "${XCCDF_RESULT_FAIL}"
    fi
fi

exit "${XCCDF_RESULT_PASS}"

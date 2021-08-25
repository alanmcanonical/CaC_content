#!/bin/bash
#
# platform = multi_platform_ubuntu
# check-import = stdout
# check-export = var_firewall_package=fw_choice
#
# "Copyright 2021 Canonical Limited. All rights reserved."
#
#--------------------------------------------------------

# 3.5.1.4 Ensure loopback traffic is configured: ufw_allow_in_lo
rule_type="ufw"

# verify if rule type matches the current firewall being audited
if [ "${XCCDF_VALUE_fw_choice}" != "${rule_type}" ]; then
    exit ${XCCDF_RESULT_NOT_APPLICABLE}
fi

ufw status verbose | grep -P "^Anywhere on lo\s+ALLOW IN\s+Anywhere\b"
if [ $? -ne 0 ]; then
    exit ${XCCDF_RESULT_FAIL}
fi

if [ -e /proc/sys/net/ipv6/conf/all/disable_ipv6 ] && [ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6)" -eq 0 ]; then
    ufw status verbose | grep -P "^Anywhere \(v6\) on lo\s+ALLOW IN\s+Anywhere \(v6\)\b"
    if [ $? -ne 0 ]; then
        exit ${XCCDF_RESULT_FAIL}
    fi
fi

exit ${XCCDF_RESULT_PASS}

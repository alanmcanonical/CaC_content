#!/bin/bash
# packages = {{{- ssgts_package("pam_pwquality") -}}}

{{% if 'ubuntu' in product or 'debian' in product %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/common-password
{{% else %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/system-auth
{{% endif %}}

CONF_FILE="/etc/security/pwquality.conf"

sed -i "/^.*minlen\s*=.*/d" "$CONF_FILE"

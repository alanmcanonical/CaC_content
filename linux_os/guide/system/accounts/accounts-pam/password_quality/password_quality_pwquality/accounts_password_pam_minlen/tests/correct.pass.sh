#!/bin/bash
# packages = {{{- ssgts_package("pam_pwquality") -}}}

{{% if 'ubuntu' in product or 'debian' in product %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/common-password
{{% else %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/system-auth
{{% endif %}}

CONF_FILE="/etc/security/pwquality.conf"

if grep -q "^.*minlen\s*=" "$CONF_FILE"; then
	sed -i "s/^.*minlen\s*=.*/minlen = 15/" "$CONF_FILE"
else
	echo "minlen = 15" >> "$CONF_FILE"
fi

#!/bin/bash

retry_cnt=3
{{% if 'ubuntu' not in product %}}
config_file="/etc/pam.d/system-auth"
{{% else %}}
config_file="/etc/pam.d/common-password"
echo "password requisite pam_pwquality.so" > $config_file
{{% endif %}}

if grep -q "pam_pwquality\.so.*retry=" "$config_file" ; then
	sed -i --follow-symlinks "/pam_pwquality\.so/ s/\(retry *= *\).*/\1$retry_cnt/" $config_file
else
	sed -i --follow-symlinks "/pam_pwquality\.so/ s/$/ retry=$retry_cnt/" $config_file
fi

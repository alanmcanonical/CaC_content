#!/bin/bash

{{% if 'ubuntu' not in product %}}
config_file="/etc/pam.d/system-auth"
{{% else %}}
config_file="/etc/pam.d/common-password"
{{% endif %}}

if grep -q "pam_pwquality\.so.*retry=" "$config_file" ; then
	sed -i --follow-symlinks "/pam_pwquality\.so/ s/\(retry *= *\).*//" $config_file
fi

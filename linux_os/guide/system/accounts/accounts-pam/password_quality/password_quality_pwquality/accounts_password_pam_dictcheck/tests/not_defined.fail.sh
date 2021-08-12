#!/bin/bash

{{% if 'ubuntu' in product or 'debian' in product %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/common-password
{{% else %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/system-auth
{{% endif %}}

sed -i s/dictcheck.+//g /etc/security/pwquality.conf

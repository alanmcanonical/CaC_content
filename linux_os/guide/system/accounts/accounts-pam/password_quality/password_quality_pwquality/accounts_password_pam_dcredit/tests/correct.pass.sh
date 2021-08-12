#!/bin/bash

{{% if 'ubuntu' in product or 'debian' in product %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/common-password
{{% else %}}
echo "password requisite pam_pwquality.so" > /etc/pam.d/system-auth
{{% endif %}}

echo "dcredit = -1" > /etc/security/pwquality.conf

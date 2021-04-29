# platform = multi_platform_ubuntu

local pamstr=`grep '^password required pam_pwhistory.so\b.*\bremember=' /etc/pam.d/common-password`
if [ -z "$pamstr" ]; then
    echo "password required pam_pwhistory.so remember=5" >> /etc/pam.d/common-password
else
    local rememb_val=`echo -n "$pamstr" | egrep -o '\bremember=[0-9]+' | cut -d '=' -f 2`
    if [ ${rememb_val} -lt 5 ]; then
        sed -E -i "s/(^password required pam_pwhistory.so\b.*\bremember=)[0-9]+/\15/" /etc/pam.d/common-password
    fi
fi

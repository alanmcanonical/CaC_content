# platform = multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_password_pam_remember") }}}

pamstr=$(egrep '^password\s+required\s+pam_pwhistory\.so\b.*\bremember=' /etc/pam.d/common-password)
if [ -z "$pamstr" ]; then
    echo "password required pam_pwhistory.so remember=${var_password_pam_remember}" >> /etc/pam.d/common-password
else
    rememb_val=$(echo -n "$pamstr" | egrep -o '\bremember=[0-9]+' | cut -d '=' -f 2)
    if [ -z "${rememb_val}" ] || [ ${rememb_val} -lt ${var_password_pam_remember} ]; then
        sed -E -i "s/(^password\s+required\s+pam_pwhistory.so\b.*\bremember=)[0-9]*/\1${var_password_pam_remember}/" /etc/pam.d/common-password
    fi
fi

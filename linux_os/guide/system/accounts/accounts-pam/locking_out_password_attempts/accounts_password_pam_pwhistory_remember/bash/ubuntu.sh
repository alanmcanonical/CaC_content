# platform = multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_password_pam_remember") }}}

pamstr=$(egrep '^password\s+required\s+pam_pwhistory\.so\b.*\bremember=' /etc/pam.d/common-password)
if [ -z "$pamstr" ]; then
    sed -i "/pam_unix.so/ipassword    required            pam_pwhistory.so remember=${var_password_pam_remember}" /etc/pam.d/common-password
else
    rememb_val=$(echo -n "$pamstr" | egrep -o '\bremember=[0-9]+' | cut -d '=' -f 2)
    if [ -z "${rememb_val}" ] || [ ${rememb_val} -lt ${var_password_pam_remember} ]; then
        sed -E -i "s/(^password\s+required\s+pam_pwhistory.so\b.*\bremember=)[0-9]*/\1${var_password_pam_remember}/" /etc/pam.d/common-password
    fi
fi

# Check if we need to add use_authtok
first_line=$(grep -n "^password" /etc/pam.d/common-password | cut -f1 -d: | head -n 1)
pam_pwhistory_line=$(grep -n "pam_pwhistory.so" /etc/pam.d/common-password | cut -f1 -d: | head -n 1)
if [ $first_line -eq $pam_pwhistory_line ]; then
    if [[ ! $(egrep "pam_unix.so\b.*\buse_authtok" /etc/pam.d/common-password ) ]]; then
        sed -i "s/pam_unix.so/& use_authtok/" /etc/pam.d/common-password
    fi
else
    if [[ ! $(egrep "pam_pwhistory.so\b.*\buse_authtok" /etc/pam.d/common-password ) ]]; then
        sed -E -i 's/pam_pwhistory.so/& use_authtok/' /etc/pam.d/common-password
    fi
fi
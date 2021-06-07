# platform = multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_ubuntu,multi_platform_wrlinux
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_accounts_password_set_min_life_existing") }}}

for usr in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1); do
    chage --mindays "${var_accounts_password_set_min_life_existing}" "${usr}"
done

# platform = multi_platform_sle,multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions

{{{ bash_instantiate_variables("var_accounts_passwords_pam_tally2_deny") }}}
# Use a non-number regexp to force update of the value of the deny option
ensure_pam_module_options '/etc/pam.d/common-auth' 'auth' 'required' 'pam_tally2.so' 'deny' '°' "${var_accounts_passwords_pam_tally2_deny}" 'top'
ensure_pam_module_options '/etc/pam.d/common-auth' 'auth' 'required' 'pam_tally2.so' 'onerr' '(fail)' 'fail' 'top'
ensure_pam_module_options '/etc/pam.d/common-account' 'account' 'required' 'pam_tally2.so' '' '' '' 'bottom'

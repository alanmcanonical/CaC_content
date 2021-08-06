#platform = multi_platform_all

. /usr/share/scap-security-guide/remediation_functions

{{{ bash_instantiate_variables("var_sshd_allow_users_valid") }}}

# We don't add the default magic value to the sshd config file, since it's a security risk.
default_value="e39d05b72f25767869d44391919434896bb055772d7969f74472032b03bc18418911f3b0e6dd47ff8f3b2323728225286c3cb36914d28dc7db40bdd786159c0a"

if [ "${var_sshd_allow_users_valid}" != ${default_value} ]; then
    {{{ bash_sshd_config_set("AllowUsers", "$var_sshd_allow_users_valid") }}}
fi

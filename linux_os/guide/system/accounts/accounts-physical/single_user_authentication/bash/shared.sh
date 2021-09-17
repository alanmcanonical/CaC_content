# platform = multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_root_passwd_hash") }}}

# Only applies the hash to /etc/shadow if the variable contains a value different from '*', '!'
# or empty
if [ -n "${var_root_passwd_hash/+([[:blank:]])/}" ] && [ "${var_root_passwd_hash}" != "*" ] &&\
    [ "${var_root_passwd_hash}" != "!" ]; then
    sed -Ei "s@^root:[^:]*@root:${var_root_passwd_hash}@" /etc/shadow
fi

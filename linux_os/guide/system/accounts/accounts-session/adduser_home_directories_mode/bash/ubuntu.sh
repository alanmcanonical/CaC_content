# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_adduser_home_directories_mode") }}}

valid_mode=${var_adduser_home_directories_mode}
adduser_conf=/etc/adduser.conf

dir_mode="$(awk -F= '/^\s*DIR_MODE\s*=\s*[0-7]?[0-7]{3}/{ printf("%04d", strtonum($2)) }' ${adduser_conf})"
if [ -z "${dir_mode}" ] || [ $(( $dir_mode & 0$valid_mode )) -ne "${dir_mode}" ]; then
    sed -i '/^\s*DIR_MODE\b/d' ${adduser_conf}
    echo 'DIR_MODE='"${valid_mode}" >> ${adduser_conf}
fi

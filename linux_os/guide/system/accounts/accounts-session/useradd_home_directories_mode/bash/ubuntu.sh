# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_useradd_home_directories_mode") }}}

valid_mode=${var_useradd_home_directories_mode}
useradd_conf=/etc/login.defs

home_mode="$(awk -F= '/^\s*HOME_MODE\s*=\s*[0-7]?[0-7]{3}/{ printf("%04d", strtonum($2)) }' ${useradd_conf})"
if [ -z "${home_mode}" ] || [ $(( $home_mode & 0$valid_mode )) -ne "${home_mode}" ]; then
    sed -i '/^\s*HOME_MODE\b/d' ${useradd_conf}
    echo -e 'HOME_MODE\t'"${valid_mode}" >> ${useradd_conf}
fi

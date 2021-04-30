# platform = multi_platform_ubuntu

# Needs variable for default umask.

useradd_conf=/etc/login.defs

v=$(grep -Po '(?<=^UMASK\b)' ${useradd_conf} | sed -E s/^\s+//)
if [ -n "${v}" ]; then
    # check if num passes valid mask
    if [ $((0${v} & 00750)) -ne 0 ]; then
        sed -E -i 's/(^UMASK\s+).*$/\1027/g' "${useradd_conf}"
    fi
else
    echo 'UMASK           027' >> "${useradd_conf}"
fi

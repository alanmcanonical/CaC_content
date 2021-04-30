# platform = multi_platform_ubuntu

# Needs default mode variable.

adduser_conf=/etc/adduser.conf
v=$(grep -Po '(?<=^DIR_MODE=)\d?\d{3}' ${adduser_conf})
if [ -n "${v}" ]; then
    # check if num passes valid mask
    if [ $((0${v} & 07027)) -ne 0 ]; then
        sed -E -i 's/(^DIR_MODE=).*$/\10750/g' ${adduser_conf}
    fi
else
    echo 'DIR_MODE=0750' >> ${adduser_conf}
fi

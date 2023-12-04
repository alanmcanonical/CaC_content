# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_sle,multi_platform_ubuntu
# reboot = false
# strategy = configure
# complexity = low
# disruption = medium

for FILE in "/etc/pam.d/common-auth" "/etc/pam.d/common-password"; do
    sed -i 's/\(.*pam_unix\.so.*\)\s\<nullok\>\(.*\)/\1\2/g' ${FILE}
done

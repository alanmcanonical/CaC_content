# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

for file in /etc/apt/apt.conf.d/*; do
    if [ -e "$file" ]; then
        if grep -qi "APT::Get::AllowUnauthenticated" $file; then
            sed -i --follow-symlinks "s/^.*APT::Get::AllowUnauthenticated.*/APT::Get::AllowUnauthenticated \"false\";/I" $file
        fi
    fi
done

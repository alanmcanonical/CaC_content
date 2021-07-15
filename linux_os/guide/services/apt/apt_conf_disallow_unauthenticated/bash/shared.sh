# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

for file in /etc/apt/apt.conf.d/*; do
    if [ -e "$file" ]; then
        if grep -q "APT::Get::AllowUnauthenticated" $file; then
            # even though we use replace_or_append, the interest here is only in replace
            # as we won't be appending because of the above 'if' check
            replace_or_append $file 'APT::Get::AllowUnauthenticated' 'false' '@CCENUM@' '%s %s'
        fi
    fi
done

# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

if [ -f /etc/aide/aide.conf ]; then
    for i in  'auditctl' 'auditd' 'ausearch' 'aureport' 'autrace' 'audispd' 'augenrules'; do
        sed -i --follow-symlinks "/^\/sbin\/$i .*/{h;s/ .*/ p+i+n+u+g+s+b+acl+xattrs+sha512/};\${x;/^$/{s//\/sbin\/$i p+i+n+u+g+s+b+acl+xattrs+sha512/;H};x}" /etc/aide/aide.conf
    done
fi

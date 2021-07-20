# platform = multi_platform_ubuntu

if LC_ALL=C grep -iw log_file /etc/audit/auditd.conf; then
    FILE=$(awk -F "=" '/^log_file/ {print $2}' /etc/audit/auditd.conf | tr -d ' ')
    GROUP=$(awk -F "=" '/^log_group/ {print $2}' /etc/audit/auditd.conf | tr -d ' ')
    if [ "$GROUP" != 'root' ] | [ "$GROUP" != 'adm' ] ; then
        chown :adm "$FILE"
        sed -i '/^log_group/D' /etc/audit/auditd.conf
        sed -i /^log_file/a'log_group = adm' /etc/audit/auditd.conf
        systemctl kill auditd -s SIGHUP
    fi
else
    chown :adm /var/log/audit/
    sed -i -e '$alog_file = /var/log/audit/audit.log' /etc/audit/auditd.conf
    sed -i /^log_file/a'log_group = adm' /etc/audit/auditd.conf
    systemctl kill auditd -s SIGHUP
fi

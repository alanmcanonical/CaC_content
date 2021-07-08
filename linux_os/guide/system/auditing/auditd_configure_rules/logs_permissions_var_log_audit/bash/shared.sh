# platform = multi_platform_ubuntu

if LC_ALL=C grep -iw log_file /etc/audit/auditd.conf; then
    FILE=$(awk -F "=" '/^log_file/ {print $2}' /etc/audit/auditd.conf | tr -d ' ')
    chmod 0600 "$FILE"
else
    chmod 0600 /var/log/audit/*
fi

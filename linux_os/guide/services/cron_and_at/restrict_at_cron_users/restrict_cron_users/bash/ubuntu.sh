# platform = multi_platform_ubuntu

rm -rf /etc/cron.deny
touch /etc/cron.allow
chmod 640 /etc/cron.allow

# platform=multi_platform_ubuntu

sed -i '/DIR_MODE=/d' /etc/adduser.conf

echo 'DIR_MODE=0700' >> /etc/adduser.conf

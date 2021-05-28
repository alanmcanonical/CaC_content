# platform = multi_platform_ubuntu

sed -i -E 's/(\\s|\\v|\\m|\\r)//g' /etc/motd

source /etc/os-release
sed -i "s#$ID##g" /etc/motd

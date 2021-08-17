# platform=multi_platform_ubuntu

sed -i '/^HOME_MODE/d; /^UMASK/d' /etc/login.defs
echo -e "UMASK\t027" >> /etc/login.defs

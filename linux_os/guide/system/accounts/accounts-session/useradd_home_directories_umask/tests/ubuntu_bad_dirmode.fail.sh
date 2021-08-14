# platform=multi_platform_ubuntu

sed -i '/^HOME_MODE/d; /^UMASK/d' /etc/login.defs
echo -e "HOME_MODE\tbadhomemode" >> /etc/login.defs
echo -e "UMASK\t000" >> /etc/login.defs

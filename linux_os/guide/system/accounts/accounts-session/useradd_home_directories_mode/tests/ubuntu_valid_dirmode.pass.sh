# platform=multi_platform_ubuntu

sed -i '/HOME_MODE/d' /etc/login.defs

echo -e 'HOME_MODE\t0700' >> /etc/login.defs

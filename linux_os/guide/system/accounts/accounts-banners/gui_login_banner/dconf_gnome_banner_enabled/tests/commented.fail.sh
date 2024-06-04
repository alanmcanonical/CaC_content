#!/bin/bash
# platform = multi_platform_ubuntu
# packages = gdm3

source $SHARED/dconf_test_functions.sh

clean_dconf_settings

add_dconf_profiles
cat > /etc/gdm3/greeter.dconf-defaults <<EOF
[org/gnome/login-screen]
#banner-message-enable=true
EOF

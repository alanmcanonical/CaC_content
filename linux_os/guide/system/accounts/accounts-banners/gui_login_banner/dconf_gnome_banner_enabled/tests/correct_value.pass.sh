#!/bin/bash

# we don't use packages statement here since Ubuntu uses different packages from other distros.

{{% set dconf_db = "distro.d" %}}
{{% if product not in ("fedora", "rhel9") %}}
{{% set dconf_db = "gdm.d" %}}
{{% endif %}}


{{% if 'ubuntu' not in product %}}
    source $SHARED/dconf_test_functions.sh

    install_dconf_and_gdm_if_needed

    clean_dconf_settings
    add_dconf_setting "org/gnome/login-screen" "banner-message-enable" "true" "{{{ dconf_db }}}" "00-security-settings"
    add_dconf_lock "org/gnome/login-screen" "banner-message-enable" "{{{ dconf_db }}}" "00-security-settings"
{{% else %}}
    apt update
    apt install gdm3 -y
    conffile="/etc/gdm3/greeter.dconf-defaults"
    sed -i '/banner-message-enable=/d;/banner-message-text=/d' ${conffile}
    sed -i "/^\[org\/gnome\/login-screen\]/a""banner-message-enable=true" ${conffile}
{{% endif %}}

dconf update

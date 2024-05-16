#!/bin/bash
# we don't use packages statement here since Ubuntu uses different packages from other distros.


install_dconf_and_gdm_if_needed
clean_dconf_settings

add_dconf_profiles
add_dconf_setting "org/gnome/login-screen" "disable-user-list" "false" "{{{ dconf_gdm_dir }}}" "00-security-settings"
add_dconf_lock "org/gnome/login-screen" "disable-user-list" "{{{ dconf_gdm_dir }}}" "00-security-settings-lock"

dconf update

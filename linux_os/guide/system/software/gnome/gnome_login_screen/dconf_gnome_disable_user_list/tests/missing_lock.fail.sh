#!/bin/bash
# packages = gdm3

. $SHARED/dconf_test_functions.sh

install_dconf_and_gdm_if_needed
clean_dconf_settings

add_dconf_profiles
add_dconf_setting "org/gnome/login-screen" "disable-user-list" "true" "{{{ dconf_gdm_dir }}}" "00-security-settings"

dconf update

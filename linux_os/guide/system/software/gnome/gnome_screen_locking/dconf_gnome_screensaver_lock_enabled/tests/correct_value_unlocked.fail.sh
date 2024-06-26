#!/bin/bash
# packages = dconf,gdm

. $SHARED/dconf_test_functions.sh

clean_dconf_settings
add_dconf_profiles

{{% if 'sle' in product %}}
add_dconf_settings "org/gnome/desktop/lockdown", "disable-lock-screen", "false", "local.d", "00-security-settings"
{{% else %}}
add_dconf_setting "org/gnome/desktop/screensaver" "lock-enabled" "true" "local.d" "00-security-settings"
{{% endif %}}

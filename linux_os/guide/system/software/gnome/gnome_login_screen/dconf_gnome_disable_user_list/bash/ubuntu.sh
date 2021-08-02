# platform = multi_platform_ubuntu

# Will do both approach, since we plan to migrate to checks over dconf db. That way, future updates of the tool
# will pass the check even if we decide to check only for the dconf db path.
{{{ set_config_file("/etc/gdm3/greeter.dconf-defaults", "disable-user-list", value="true", create='no', insert_after="\[org/gnome/login-screen\]", insert_before="", separator="=", separator_regex="", prefix_regex="^\s*") }}}
{{{ bash_dconf_settings("org/gnome/login-screen", "disable-user-list", "true", dconf_gdm_dir, "00-security-settings") }}}
# No need to use dconf update, since bash_dconf_settings does that already

# platform = multi_platform_ubuntu
# reboot = true
# disruption = high

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

{{{ bash_instantiate_variables("var_set_apparmor_enforce_mode") }}}
local lvl1_aa_enforce=${var_set_apparmor_enforce_mode}

# apparmor and apparmor-utils must be installed to be compliant to this rule.
{{{ bash_package_installed("apparmor") }}} || DEBIAN_FRONTEND=noninteractive apt-get install apparmor -y
{{{ bash_package_installed("apparmor-utils") }}} || DEBIAN_FRONTEND=noninteractive apt-get install apparmor-utils -y

if [ -z "${lvl1_aa_enforce}" ] || [ "${lvl1_aa_enforce}" != true ]; then
    aa-complain /etc/apparmor.d/*
else
    aa-enforce /etc/apparmor.d/*
fi

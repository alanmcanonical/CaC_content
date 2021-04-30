# platform = multi_platform_ubuntu
# reboot = true
# disruption = high

# Needs variable.
# local lvl1_aa_enforce=$(read_usr_param lvl1_apparmor_enforce)
local lvl1_aa_enforce="false"

# apparmor and apparmor-utils must be installed to be compliant to this rule.
{{{ bash_package_installed("apparmor") }}} || apt-get install apparmor -y
{{{ bash_package_installed("apparmor-utils") }}} || apt-get install apparmor-utils -y

if [ -z "${lvl1_aa_enforce}" ] || [ "${lvl1_aa_enforce}" != true ]; then
    aa-complain /etc/apparmor.d/*
else
    aa-enforce /etc/apparmor.d/*
fi

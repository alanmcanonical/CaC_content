# platform = multi_platform_ubuntu
# reboot = true
# disruption = high

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

# apparmor and apparmor-utils must be installed to be compliant to this rule.
{{{ bash_package_installed("apparmor") }}} || DEBIAN_FRONTEND=noninteractive apt-get install apparmor -y
{{{ bash_package_installed("apparmor-utils") }}} || DEBIAN_FRONTEND=noninteractive apt-get install apparmor-utils -y

aa-enforce /etc/apparmor.d/*

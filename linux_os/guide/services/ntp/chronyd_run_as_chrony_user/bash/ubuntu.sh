# platform = multi_platform_ubuntu

CHRONY_CONF={{{ chrony_conf_path }}}

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

{{{ bash_replace_or_append("${CHRONY_CONF}", '^user', '_chrony', '@CCENUM@', '%s %s') }}}

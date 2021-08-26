# platform = multi_platform_ubuntu

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

{{{ bash_instantiate_variables("sshd_approved_kexs") }}}

{{{ bash_replace_or_append('/etc/ssh/sshd_config', '^KexAlgorithms', "$sshd_approved_kexs", '@CCENUM@', '%s %s') }}}

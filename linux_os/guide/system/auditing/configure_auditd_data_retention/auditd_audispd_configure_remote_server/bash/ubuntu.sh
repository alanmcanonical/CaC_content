# platform = multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_audispd_remote_server") }}}

AUREMOTECONFIG=/etc/audisp/plugins.d/au-remote.conf
AUDITCONFIG=/etc/audisp/audisp-remote.conf

replace_or_append $AUREMOTECONFIG '^active' 'yes' '@CCENUM@'
replace_or_append $AUDITCONFIG '^remote_server' "$var_audispd_remote_server" "@CCENUM@"

#!/bin/bash
# platform = multi_platform_all

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

{{{ bash_instantiate_variables("var_sshd_set_loglevel") }}}

{{{ bash_sshd_config_set(parameter="LogLevel", value="$var_sshd_set_loglevel") }}}

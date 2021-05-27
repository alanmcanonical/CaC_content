# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

{{{ bash_instantiate_variables("login_banner_text") }}}

echo "$login_banner_text" > /etc/issue.net

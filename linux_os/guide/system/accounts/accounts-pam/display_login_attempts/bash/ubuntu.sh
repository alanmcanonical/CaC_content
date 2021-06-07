# platform = multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions

ensure_pam_module_options '/etc/pam.d/login' 'session' 'required' 'pam_lastlog.so' 'showfailed' '' '' 'silent'

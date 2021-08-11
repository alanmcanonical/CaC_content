# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

ensure_pam_module_options '/etc/pam.d/common-auth' 'auth' '[success=2 default=ignore]' 'pam_pkcs11.so' '' '' ''

# platform = multi_platform_ubuntu

ensure_pam_module_options '/etc/pam.d/common-auth' 'auth' '[success=2 default=ignore]' 'pam_pkcs11.so' '' '' ''

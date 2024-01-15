#!/bin/bash

# packages = libpam-pkcs11

sed -i '/^auth.*pam_unix.so/i auth [success=2 default=ignore] pam_pkcs11.so' /etc/pam.d/common-auth

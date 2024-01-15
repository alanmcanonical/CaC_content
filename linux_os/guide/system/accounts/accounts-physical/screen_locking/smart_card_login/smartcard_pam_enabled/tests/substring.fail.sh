#!/bin/bash

sed -i '/^auth.*pam_unix.so/i aauth [success=2 default=ignore] pam_pkcs11.so' /etc/pam.d/common-auth

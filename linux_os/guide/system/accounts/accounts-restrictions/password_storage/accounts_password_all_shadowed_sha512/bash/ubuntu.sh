# platform = multi_platform_ubuntu

if ! grep '^password\s\+.*\bpam_unix\.so\b.*\bsha512\b' /etc/pam.d/common-password; then
    sed -i 's/\(password\b.*\bpam_unix\.so\b.*\)$/\1 sha512/' /etc/pam.d/common-password
fi

# platforms = multi_platform_ubuntu

sed -i "/password\s+required\s+pam_pwhistory\.so\s+.*remember=/d" /etc/pam.d/common-password
echo "password required pam_pwhistory.so remember=100" >> /etc/pam.d/common-password

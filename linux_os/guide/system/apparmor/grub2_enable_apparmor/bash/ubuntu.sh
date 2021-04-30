# platform = multi_platform_ubuntu

. /usr/share/scap-security-guide/remediation_functions

add_kernel_boot_param apparmor 1
add_kernel_boot_param security apparmor
do_update_grub

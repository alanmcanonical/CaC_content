# platform = multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_ubuntu,multi_platform_wrlinux
# reboot = false
# complexity = low
# disruption = low

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

fix_audit_watch_rule "auditctl" "/usr/bin/kmod" "x" "modules"
fix_audit_watch_rule "augenrules" "/usr/bin/kmod" "x" "modules"

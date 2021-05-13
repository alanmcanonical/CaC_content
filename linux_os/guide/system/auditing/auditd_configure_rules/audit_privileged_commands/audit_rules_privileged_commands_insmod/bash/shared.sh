# platform = multi_platform_sle,multi_platform_wrlinux,multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_ubuntu
# reboot = false
# complexity = low
# disruption = low

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

# Perform the remediation for both possible tools: 'auditctl' and 'augenrules'
fix_audit_watch_rule "auditctl" "/sbin/insmod" "x" "modules"
fix_audit_watch_rule "augenrules" "/sbin/insmod" "x" "modules"

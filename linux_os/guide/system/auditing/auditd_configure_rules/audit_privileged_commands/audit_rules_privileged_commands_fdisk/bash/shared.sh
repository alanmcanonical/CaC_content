# platform = multi_platform_all
# reboot = false
# complexity = low
# disruption = low

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

# Perform the remediation for both possible tools: 'auditctl' and 'augenrules'
fix_audit_watch_rule "auditctl" "/sbin/fdisk" "x" "modules"
fix_audit_watch_rule "augenrules" "/sbin/fdisk" "x" "modules"

# platform = multi_platform_ubuntu

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

fix_audit_watch_rule "auditctl" "/var/log/sudo.log" "wa" "maintenance"
fix_audit_watch_rule "augenrules" "/var/log/sudo.log" "wa" "maintenance"

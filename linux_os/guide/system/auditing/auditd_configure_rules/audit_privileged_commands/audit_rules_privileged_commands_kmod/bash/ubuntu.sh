# platform = multi_platform_ubuntu
# reboot = false
# complexity = low
# disruption = low

# Include source function library.
. /usr/share/scap-security-guide/remediation_functions

fix_audit_watch_rule "auditctl" "/bin/kmod" "x" "modules"
fix_audit_watch_rule "augenrules" "/bin/kmod" "x" "modules"

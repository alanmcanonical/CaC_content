# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_ubuntu
# Include source function library.
. /usr/share/scap-security-guide/remediation_functions


# Perform the remediation for both possible tools: 'auditctl' and 'augenrules'
{{% if 'ubuntu' not in product %}}
fix_audit_watch_rule "auditctl" "/etc/selinux/" "wa" "MAC-policy"
fix_audit_watch_rule "augenrules" "/etc/selinux/" "wa" "MAC-policy"
{{% else %}}
fix_audit_watch_rule "auditctl" "/etc/apparmor/" "wa" "MAC-policy"
fix_audit_watch_rule "auditctl" "/etc/apparmor.d/" "wa" "MAC-policy"
fix_audit_watch_rule "augenrules" "/etc/apparmor/" "wa" "MAC-policy"
fix_audit_watch_rule "augenrules" "/etc/apparmor.d/" "wa" "MAC-policy"
{{% endif %}}

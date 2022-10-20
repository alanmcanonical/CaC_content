# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_ubuntu,multi_platform_wrlinux

. /usr/share/scap-security-guide/remediation_functions

{{% if product in ["sle12", "sle15"] or 'ubuntu' in product %}}
{{% set pam_lastlog_path = "/etc/pam.d/login" %}}
{{% else %}}
{{% set pam_lastlog_path = "/etc/pam.d/postlogin" %}}
{{% endif %}}

ensure_pam_module_options '{{{ pam_lastlog_path }}}' 'session' 'required' 'pam_lastlog.so' 'showfailed' "" "" 'bottom' 'silent'

# remove 'silent' option
sed -i --follow-symlinks -E -e 's/^([^#]+pam_lastlog\.so[^#]*)\ssilent/\1/' '{{{ pam_lastlog_path }}}'

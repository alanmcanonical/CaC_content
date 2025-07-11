# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low

{{{ bash_instantiate_variables("var_accounts_maximum_age_login_defs") }}}

{{% call iterate_over_command_output("i", "awk -v var=\"$var_accounts_maximum_age_login_defs\" -F: '(/^[^:]+:[^!*]/ && ($5 > var || $5 == \"\")) {print $1}' /etc/shadow") -%}}
{{% if product in ["sle12", "sle15", "slmicro6"] %}}
passwd -q -x $var_accounts_maximum_age_login_defs $i
{{% else %}}
chage -M $var_accounts_maximum_age_login_defs $i
{{% endif %}}
{{%- endcall %}}

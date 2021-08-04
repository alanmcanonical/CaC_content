# platform = Red Hat Virtualization 4,multi_platform_rhel,multi_platform_wrlinux,multi_platform_ol,multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_time_service_set_maxpoll") }}}


{{% if 'ubuntu' not in product %}}
pof="/usr/sbin/pidof"
{{% else %}}
pof="/bin/pidof"
{{% endif %}}

config_file="/etc/ntp.conf"
$pof ntpd || config_file="{{{ chrony_conf_path }}}"


# Set maxpoll values to var_time_service_set_maxpoll
sed -i "s/^\(server.*maxpoll\) [0-9][0-9]*\(.*\)$/\1 $var_time_service_set_maxpoll \2/" "$config_file"

# Add maxpoll to server entries without maxpoll
grep "^server" "$config_file" | grep -v maxpoll | while read -r line ; do
        sed -i "s/$line/& maxpoll $var_time_service_set_maxpoll/" "$config_file"
done

# Add maxpoll to peer entries without maxpoll
grep "^peer" "$config_file" | grep -v maxpoll | while read -r line ; do
        sed -i "s/$line/& maxpoll $var_time_service_set_maxpoll/" "$config_file"
done

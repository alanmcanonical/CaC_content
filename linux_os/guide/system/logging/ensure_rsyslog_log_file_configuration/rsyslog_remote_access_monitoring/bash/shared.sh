# platform = multi_platform_all

declare -A REMOTE_METHODS=( ['auth.*']='^[^#]*auth\.\*.*$' ['authpriv.*']='^[^#]*authpriv\.\*.*$' ['daemon.*']='^[^#]*daemon\.\*.*$' )
declare -A LOCATIONS=( ['rsyslog_remote_access_monitoringauth.*']='/var/log/secure' ['authpriv.*']='/var/log/secure' ['daemon.*']='/var/log/messages' )
{{% if 'ubuntu' in product %}}
rsyslog_remote_access_monitoring_path=/etc/rsyslog.d/50-default.conf
mkdir -p /etc/rsyslog.d/
chmod 0755 /etc/rsyslog.d/
{{%- else %}}
rsyslog_remote_access_monitoring_path=/etc/rsyslog.conf
{{% endif %}}

if [[ ! -f $rsyslog_remote_access_monitoring_path ]]; then
	# Something is not right, create the file
	touch $rsyslog_remote_access_monitoring_path
	chmod 0644 $rsyslog_remote_access_monitoring_path
fi


# Loop through the remote methods associative array
for K in "${!REMOTE_METHODS[@]}"
do
	# Check to see if selector/value exists
	if ! grep -rq "${REMOTE_METHODS[$K]}" /etc/rsyslog.*; then
        APPEND_LINE=$(sed -rn "/^\S+\s+\${LOCATIONS[$K]}$/p" $rsyslog_remote_access_monitoring_path)
		# Make sure we have a line to insert after, otherwise append to end
		if [[ ! -z ${APPEND_LINE} ]]; then
			# Add selector to file
			sed -r -i "0,/^(\S+\s+\/var\/log\/secure$)/s//\1\n${K} \/var\/log\/secure/" $rsyslog_remote_access_monitoring_path
		else
			echo "${K} ${LOCATIONS[$K]}" >> $rsyslog_remote_access_monitoring_path
		fi
	fi
done

{{% if 'ubuntu' in product %}}
systemctl restart rsyslog.service
{{% endif %}}

# platform = multi_platform_ubuntu
# reboot = true
# disruption = high

# apparmor and apparmor-utils must be installed to be compliant to this rule.
{{{ bash_package_install("apparmor") }}}
{{{ bash_package_install("apparmor-utils") }}}

# Ensure all AppArmor Profiles are enforcing
apparmor_parser -q -r /etc/apparmor.d/
aa-enforce /etc/apparmor.d/*

{{% if 'ubuntu' in product %}}
UNCONFINED=$(aa-status | grep "processes are unconfined" | awk '{print $1;}')
if [ $UNCONFINED -ne 0 ];
{{% else %}}
UNCONFINED=$(aa-unconfined)
if [ ! -z "$UNCONFINED" ]
{{% endif %}}
then
  echo -e "***WARNING***: There are some unconfined processes:"
  echo -e "----------------------------"
  echo "The may need to have a profile created or activated for them and then be restarted."
  for PROCESS in "${UNCONFINED[@]}"
  do
      echo "$PROCESS"
  done
  echo -e "----------------------------"
  echo "The may need to have a profile created or activated for them and then be restarted."
fi

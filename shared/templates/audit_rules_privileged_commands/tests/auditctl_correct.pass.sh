#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

{{% if product in ["rhel8", "rhel9", "sle12", "sle15", "ubuntu2004"] %}}
  {{% set perm_x=" -F perm=x" %}}
{{% endif %}}

echo "-a always,exit -F path={{{ PATH }}}{{{ perm_x }}} -F auid>={{{ auid }}} -F auid!=unset -F key=privileged" >> /etc/audit/audit.rules
sed -i "s%^ExecStartPost=.*%ExecStartPost=-/sbin/auditctl%" /usr/lib/systemd/system/auditd.service

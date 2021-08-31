#!/bin/bash
# packages = {{{ ssgts_package("audit") }}}

{{%- if product in ["rhel8", "rhel9", "sle12", "sle15", "ubuntu2004"] %}}
  {{%- set perm_x=" -F perm=x" %}}
{{%- endif %}}

mkdir -p /etc/audit/rules.d
echo "-a always,exit -F path={{{ PATH }}}{{{ perm_x }}} -F auid>={{{ auid }}} -F auid!=unset -F key=privileged" >> /etc/audit/rules.d/privileged.rules

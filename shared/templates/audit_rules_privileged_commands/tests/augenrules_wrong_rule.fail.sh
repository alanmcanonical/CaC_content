#!/bin/bash

mkdir -p /etc/audit/rules.d
echo "-a always -F path={{{ PATH }}} -F auid>={{{ auid }}} -F auid!=unset -F key=privileged" >> /etc/audit/rules.d/privileged.rules

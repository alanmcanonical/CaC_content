#!/bin/bash

echo "-a always -F path={{{ PATH }}} -F auid>={{{ auid }}} -F auid!=unset -F key=privileged" >> /etc/audit/audit.rules

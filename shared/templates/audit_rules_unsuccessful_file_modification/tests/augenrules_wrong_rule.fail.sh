#!/bin/bash

echo '-a always -F arch=b32 -S {{{ NAME }}} -F exit=-EACCES -F auid>={{{ auid }}} -F auid!=unset -F key=unsuccesful-access' >> /etc/audit/rules.d/unsuccesful-access.rules
echo '-a always -F arch=b64 -S {{{ NAME }}} -F exit=-EACCES -F auid>={{{ auid }}} -F auid!=unset -F key=unsuccesful-access' >> /etc/audit/rules.d/unsuccesful-access.rules
echo '-a always -F arch=b32 -S {{{ NAME }}} -F exit=-EPERM -F auid>={{{ auid }}} -F auid!=unset -F key=unsuccesful-access' >> /etc/audit/rules.d/unsuccesful-access.rules
echo '-a always -F arch=b64 -S {{{ NAME }}} -F exit=-EPERM -F auid>={{{ auid }}} -F auid!=unset -F key=unsuccesful-access' >> /etc/audit/rules.d/unsuccesful-access.rules

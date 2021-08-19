#!/bin/bash

echo '-a always,exit -F arch=b32 -S {{{ NAME }}} -F auid>={{{ auid }}} -F auid!=unset -F key=delete' >> /etc/audit/rules.d/delete.rules
echo '-a always,exit -F arch=b64 -S {{{ NAME }}} -F auid>={{{ auid }}} -F auid!=unset -F key=delete' >> /etc/audit/rules.d/delete.rules

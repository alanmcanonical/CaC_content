#!/bin/bash
# platform = multi_platform_ubuntu

# Any value other than '!', '*', space or empty is considered valid
sed -E -i "s@^root:[^:]*@root:AAAAAA@" /etc/shadow

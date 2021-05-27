#!/bin/bash
# platform = multi_platform_all

source /etc/os-release

echo "This is my motd for the host $ID." > /etc/motd

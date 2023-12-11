#!/bin/bash

# platform = multi_platform_ubuntu

source common.sh

echo "{{{ PARAMETER }}} {{{ VALUE }}}" > /etc/ssh/sshd_config.d/first.conf
echo "{{{ PARAMETER }}} {{{ VALUE }}}" > /etc/ssh/sshd_config.d/second.conf

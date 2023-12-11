#!/bin/bash

# platform = multi_platform_ubuntu

source common.sh

echo "{{{ PARAMETER }}} {{{ VALUE }}}" > /etc/ssh/sshd_config.d/good_config.conf
echo "{{{ PARAMETER }}} thisvaluecantpossiblybecorrect" > /etc/ssh/sshd_config.d/bad_config.conf

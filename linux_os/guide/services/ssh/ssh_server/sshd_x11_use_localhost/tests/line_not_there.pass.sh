#!/bin/bash

sed -i "/^X11UseLocalhost.*/d" /etc/ssh/sshd_config

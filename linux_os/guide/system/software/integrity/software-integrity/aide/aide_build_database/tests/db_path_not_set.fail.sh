#!/bin/bash
# packages = aide

if grep -qE 'DISTRIB_ID=Ubuntu' /etc/lsb-release; then
    sed -Ei '/^database=file:/'d /etc/aide/aide.conf
else
    sed -Ei '/^database=file:/'d /etc/aide.conf
fi

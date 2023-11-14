#!/bin/bash
# packages = aide

if grep -qE 'DISTRIB_ID=Ubuntu' /etc/lsb-release; then
    DB=/var/lib/aide/aide.db
else
    DB=/var/lib/aide/aide.db.gz
fi

rm -rf $DB

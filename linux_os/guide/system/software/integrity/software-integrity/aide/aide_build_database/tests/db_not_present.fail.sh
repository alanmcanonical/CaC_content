#!/bin/bash
# packages = aide

if grep -qE 'DISTRIB_ID=Ubuntu' /etc/lsb-release; then
    DB=/var/lib/aide/aide.db.gz
else
    DB=/var/lib/aide/aide.db
fi

rm -rf $DB

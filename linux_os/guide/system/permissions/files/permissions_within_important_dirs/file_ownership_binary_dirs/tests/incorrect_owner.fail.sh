#!/bin/bash

useradd testuser_123

for LIBDIR in /bin/ /usr/bin/ /usr/local/bin/ /sbin/ /usr/sbin/ /usr/local/sbin/ /usr/libexec
do
    if [ -d $LIBDIR ]; then
        find -L $LIBDIR \! -user testuser_123 -execdir chown testuser_123 {} \;
    fi
done

#!/bin/bash

for LIBDIR in /bin/ /usr/bin/ /usr/local/bin/ /sbin/ /usr/sbin/ /usr/local/sbin/ /usr/libexec
do
    if [ -d $LIBDIR ]; then
        find -L $LIBDIR \! -user root -execdir chown root {} \;
    fi
done

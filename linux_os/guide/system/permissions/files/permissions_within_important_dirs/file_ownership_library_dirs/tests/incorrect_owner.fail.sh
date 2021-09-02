#!/bin/bash

useradd testuser_123

for LIBDIR in /usr/lib /usr/lib64 /lib /lib64
do
    if [ -d $LIBDIR ]; then
        find -L $LIBDIR \! -user testuser_123 -exec chown testuser_123 {} \;
    fi
done

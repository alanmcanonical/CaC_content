#!/bin/bash

for file in /etc/apt/apt.conf.d/*; do
    if [ -e "$file" ]; then
        if grep -qi "APT::Get::AllowUnauthenticated" $file; then
            sed -i "s/^.*APT::Get::AllowUnauthenticated.*/APT::Get::AllowUnauthenticated \"true\";/" $file
        else
            echo "APT::Get::AllowUnauthenticated \"true\";" >> $file
        fi
    fi
done

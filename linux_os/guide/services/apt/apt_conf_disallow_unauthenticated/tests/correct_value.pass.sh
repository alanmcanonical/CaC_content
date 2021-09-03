#!/bin/bash

for file in /etc/apt/apt.conf.d/*; do
    if [ -e "$file" ]; then
        if grep -qi "APT::Get::AllowUnauthenticated" $file; then
            sed -i 's/^.*APT::Get::AllowUnauthenticated.*/APT::Get::AllowUnauthenticated \"false\";/'
        else
            echo "APT::Get::AllowUnauthenticated \"false\";" >> $file
        fi
    fi
done

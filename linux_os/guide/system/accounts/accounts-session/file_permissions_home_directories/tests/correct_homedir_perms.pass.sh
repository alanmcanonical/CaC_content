#!/bin/bash

find /root /home/* -maxdepth 0 -type d -exec chmod g-w,o-rwx '{}' \;

#!/bin/bash

find /root /home/* -type f -iname '.*' -exec chmod og-w '{}' \;

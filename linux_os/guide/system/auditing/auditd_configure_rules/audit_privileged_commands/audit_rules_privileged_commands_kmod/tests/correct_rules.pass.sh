#!/bin/bash

echo "-w /usr/bin/kmod -p x -k modules" >> /etc/audit/rules.d/modules.rules

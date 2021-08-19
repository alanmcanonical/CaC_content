#!/bin/bash

echo "-w /sbin/fdisk -p x -k modules" >> /etc/audit/rules.d/modules.rules

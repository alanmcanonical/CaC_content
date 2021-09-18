#!/bin/bash
# platform = multi_platform_all
# remediation = none

useradd -m -U joas
useradd -m -U canonical

touch ~joas/.forward

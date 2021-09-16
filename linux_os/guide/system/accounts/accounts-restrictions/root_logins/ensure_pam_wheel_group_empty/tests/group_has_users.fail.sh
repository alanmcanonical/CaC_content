#!/bin/bash
# variables = var_pam_wheel_group_for_su=sugroup

GRP_NAME=sugroup

groupadd ${GRP_NAME}


useradd -m -U joas
useradd -m -U canonical

usermod -G ${GRP_NAME} -a joas
usermod -G ${GRP_NAME} -a canonical || true


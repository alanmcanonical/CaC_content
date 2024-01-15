#!/bin/bash

echo "auth	[success=1 default=ignore]	pam_unix.so nullok" > /etc/pam.d/common-auth

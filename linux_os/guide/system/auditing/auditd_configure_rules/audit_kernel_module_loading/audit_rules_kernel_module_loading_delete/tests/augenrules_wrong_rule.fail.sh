#!/bin/bash

echo '-a always -F arch=b32 -S delete_module -F key=modules' >> /etc/audit/rules.d/modules.rules
echo '-a always -F arch=b64 -S delete_module -F key=modules' >> /etc/audit/rules.d/modules.rules

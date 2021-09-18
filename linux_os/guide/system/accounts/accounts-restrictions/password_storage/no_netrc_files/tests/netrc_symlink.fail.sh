#!/bin/bash
#
# remediation = none

{{% if 'ubuntu' not in product %}}
ln -sf /bin/bash /home/.netrc
{{% else %}}

useradd -m -U joas
useradd -m -U canonical

ln -sf /bin/bash ~joas/.netrc
{{% endif %}}

# platform = multi_platform_ubuntu

find /lib /usr/lib /lib64 ! -group root -type f -exec chgrp root '{}' \;

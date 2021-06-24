# platform = multi_platform_ubuntu

DIRS="/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin"
find -L $DIRS -perm /022 -type d -exec chmod -R 755 '{}' \;

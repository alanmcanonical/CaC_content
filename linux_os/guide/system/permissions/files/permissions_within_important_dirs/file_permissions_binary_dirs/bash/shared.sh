# platform = Red Hat Virtualization 4,multi_platform_rhel,multi_platform_ol,multi_platform_ubuntu
DIRS="/bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin /usr/libexec"
find -L $DIRS -perm /022 -execdir chmod go-w '{}' \;

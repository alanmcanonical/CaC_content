# platform = multi_platform_ubuntu

for LIBDIR in /usr/lib /usr/lib64 /lib /lib64
do
  if [ -d $LIBDIR ]
  then
    find -L $LIBDIR \! -user root -type d -exec chown root {} \;
  fi
done

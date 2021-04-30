# platform = multi_platform_ubuntu

# set all system accounts to a non login shell
awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print $1}' /etc/passwd |\
while read -r user; do
    usermod -s "$(which nologin)" "$user";
done

# lock not root system accounts
awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd |\
xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}' |\
while read -r user; do
    usermod -L "$user";
done

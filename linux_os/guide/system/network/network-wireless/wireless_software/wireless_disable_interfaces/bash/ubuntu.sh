# platform = multi_platform_ubuntu

if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
    interfaces=$(ls -L -d /sys/class/net/*/wireless | xargs dirname | xargs basename)

    for i in $interfaces; do
        ifdown $i
        drivers=$(basename $(readlink -f /sys/class/net/$i/device/driver))
        echo "install $drivers /bin/true" >> /etc/modprobe.d/disable_wireless.conf
        modprobe -r $drivers
    done
    if command -v nmcli >/dev/null 2>&1 ; then
        nmcli radio all off
    fi
fi

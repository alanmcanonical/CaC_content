# Execute update grub and fix permissions changed
do_update_grub()
{
    local cfg="/boot/grub/grub.cfg"
    update-grub
    chown root:root $cfg
    chmod og-rwx $cfg
}

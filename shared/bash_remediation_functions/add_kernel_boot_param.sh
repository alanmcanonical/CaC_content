# Helper to add a grub2 boot parameter.
add_kernel_boot_param()
{
    local param_to_add="$1"
    local param_to_add_val="$2"
    local grub_cfg=/etc/default/grub

    if [ -z "${param_to_add}" ]; then
        exec_error "No parameter added to ${FUNCNAME}"
        return
    fi

    local cur_param=$(grep -Po "(?<=^GRUB_CMDLINE_LINUX=\")[^\"]*" ${grub_cfg})
    if [ $? -eq 0 ]; then
        # Remove old param, if it exist
        tmp_vec=($(echo "${cur_param}" | sed -E "s/\b${param_to_add}\b(=\S+)?//"))

        # And add new param
        if [ -z "${param_to_add_val}" ]; then
            tmp_vec+=("${param_to_add}")
        else
            tmp_vec+=("${param_to_add}=${param_to_add_val}")
        fi

        cur_param="${tmp_vec[@]}"
        # Remove old GRUB_CMDLINE_LINUX entry
        sed -i /^GRUB_CMDLINE_LINUX=/d ${grub_cfg}
    fi

    echo "GRUB_CMDLINE_LINUX=\"${cur_param}\"" >> ${grub_cfg}
}

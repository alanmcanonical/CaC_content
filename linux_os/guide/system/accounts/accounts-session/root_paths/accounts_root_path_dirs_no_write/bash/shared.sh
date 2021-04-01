# platform = multi_platform_ubuntu


fix_path() {
    local path_segments="${1//:/$'\n'}"
    local new_path=""

    local old_IFS="$IFS"
    IFS=$'\n'

    for path_part in $path_segments; do
        if [ -z "${path_part}" ] || [ "${path_part}" == "." ]; then
            continue
        fi

        local old_part="$(readlink -f "${path_part}")"
        local have_part="false"
        for new_part in ${new_path//:/$'\n'}; do
            if [ "x${old_part}" == "x${new_part}" ]; then
                have_part="true"
                break
            fi
        done

        # Do this on the resolved part, not the original part.
        /bin/chmod o-w,g-w "${old_part}"

        if [ -z "$new_path" ]; then
            new_path="${old_part}"
        else
            new_path="$new_path:${old_part}"
        fi
    done

    IFS="${old_IFS}"
    echo "$new_path"
}

PATH="$(fix_path "$PATH")"

profile_paths="/etc/skel/.profile /etc/environment /etc/crontab /etc/bash.bashrc /etc/profile /root/.profile /root/.bashrc"

/usr/bin/sed -i 's|^PATH=.*|PATH='"$PATH"'|g' $profile_paths
/usr/bin/sed -i 's|^\(.*\s\)PATH=.*|\1PATH='"$PATH"'|g' $profile_paths

defs_path="/etc/login.defs"
/usr/bin/sed -i 's|^\(.*\s\)PATH=.*|\1PATH='"$PATH"'|g' $defs_path

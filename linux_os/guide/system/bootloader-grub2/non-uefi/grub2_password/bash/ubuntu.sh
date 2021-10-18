# platform = multi_platform_ubuntu
. /usr/share/scap-security-guide/remediation_functions
{{{ bash_instantiate_variables("var_grub2_passwd_hash") }}}
{{{ bash_instantiate_variables("var_grub2_user") }}}

hdrconf=/etc/grub.d/00_header
linuxconf=/etc/grub.d/10_linux

# This removes all grub lines related to the bootloader password rule
# script
remove_grub_password_lines()
{
    local file="$1"

    if [ -z "${file}" ]; then
        return
    fi

    local num_lines_file=$(($(wc -l ${file} | cut -d' ' -f1) + 1))
    local termtor=""
    local cat_line_num=0

    # We grab the lines in the reverse order so we can remove them and not have
    # to regenerate the list.
    for pw_line_num in $(egrep -n "^password_pbkdf2 \w+ grub\.pbkdf2\." "${file}" | cut -d: -f1 | tac); do
        termtor=""
        # scan line by line up until you find a cat <<*TERMINATOR* pattern (or get to line 1)
        cat_line_num=$((pw_line_num-1))
        while [ ${cat_line_num} -gt 0 ]; do
            termtor=$(sed -n "${cat_line_num}"p ${file} | grep -Po "(?<=^cat <<)\s*[^ ]+$" | sed -E 's/^\s+//')
            if [ -n "${termtor}" ]; then
                break
            fi
            cat_line_num=$((cat_line_num-1))
        done

        # if no cat id found, we just leave without deleting anything. This format is incorrect.
        if [ -z "${termtor}" ]; then
            return
        fi

        # now scan line by line down until you find a line containing only the *TERMINATOR* (or get to the last line)
        local term_line_num=$((pw_line_num+1))
        while [ ${term_line_num} -le ${num_lines_file} ]; do
            if [ $(sed -n "${term_line_num}"p ${file}) == "${termtor}" ]; then
                break
            fi
            term_line_num=$((term_line_num+1))
        done

        # If no terminator found at the end, we just leave without deleting anything. This format is incorrect.
        if [ ${term_line_num} -gt ${num_lines_file} ]; then
            return
        fi

        # Otherwise we found the first line and the last line to be deleted, so we delete them.
        sed -i "${cat_line_num}","${term_line_num}"d ${file}
    done
}

if [ -n "${var_grub2_passwd_hash/+([[:blank:]])/}" ] && [ "${var_grub2_passwd_hash}" != "*" ]; then
    tagname="USG_GRUB2_PASSWD"

    # --unrestricted flag to allow boot without password
    # Note this still protects against unauthorized entry editing
    egrep '^CLASS=".* --unrestricted( .*)?"' ${linuxconf}
    if [ $? -ne 0 ]; then
        sed -i -E 's/^(CLASS="[^"]*)/\1 --unrestricted/' ${linuxconf}
    fi

    remove_grub_password_lines ${hdrconf}

    # Check if line to append is empty. Otherwise, add to next line.
    if [ -n "$(tail -n1 ${hdrconf})" ]; then
        echo "" >> ${hdrconf}
    fi

    echo "cat << ${tagname}" >> ${hdrconf}
    echo "set superusers=\"${var_grub2_user}\"" >> ${hdrconf}
    echo "password_pbkdf2 ${var_grub2_user} ${var_grub2_passwd_hash}" >> ${hdrconf}
    echo -n "${tagname}" >> ${hdrconf}


    #cfg="/boot/grub/grub.cfg"
    update-grub
    #chown root:root $cfg
    #chmod og-rwx $cfg
fi

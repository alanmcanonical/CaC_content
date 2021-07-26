# platform = multi_platform_all

if command -v prelink 2>/dev/null >/dev/null; then
    prelink -ua
fi

{{{ bash_package_remove("prelink") }}}

# platform = multi_platform_ubuntu

{{{ bash_iptables_installed() }}}

ip6tables -C INPUT -s ::1 -j DROP 2>/dev/null || ip6tables -A INPUT -s ::1 -j DROP
ip6tables-save > /etc/iptables/rules.v6

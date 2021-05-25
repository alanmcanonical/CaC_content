# platform = multi_platform_ubuntu

{{{ bash_iptables_installed() }}}

ip6tables -C INPUT -i lo -j ACCEPT 2>/dev/null || ip6tables -A INPUT -i lo -j ACCEPT
ip6tables-save > /etc/iptables/rules.v6

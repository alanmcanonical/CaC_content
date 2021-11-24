# platform = multi_platform_ubuntu

{{{ bash_iptables_installed() }}}

ip6tables -C OUTPUT -o lo -j ACCEPT 2>/dev/null || ip6tables -A OUTPUT -o lo -j ACCEPT
ip6tables-save -t filter > /etc/iptables/rules.v6

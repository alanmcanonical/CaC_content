# platform = multi_platform_ubuntu

{{{ bash_iptables_installed() }}}

iptables -C INPUT -i lo -j ACCEPT 2>/dev/null || iptables -A INPUT -i lo -j ACCEPT
iptables-save > /etc/iptables/rules.v4

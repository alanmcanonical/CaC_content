# platform = multi_platform_ubuntu

{{{ bash_iptables_installed() }}}

iptables -C OUTPUT -o lo -j ACCEPT 2>/dev/null || iptables -A OUTPUT -o lo -j ACCEPT
iptables-save > /etc/iptables/rules.v4

# platform = multi_platform_ubuntu

{{{ bash_iptables_installed() }}}

iptables -C INPUT -s 127.0.0.0/8 -j DROP 2>/dev/null || iptables -A INPUT -s 127.0.0.0/8 -j DROP
iptables-save -t filter > /etc/iptables/rules.v4

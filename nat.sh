#!/bin/sh -x
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

#http://www.revsys.com/writings/quicktips/nat.html

LAN="tun0"
WAN="eth1"

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

echo 1 > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -o ${WAN} -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
/sbin/iptables -t nat -A POSTROUTING -o ${WAN} -j MASQUERADE
#/sbin/iptables -A FORWARD -i ${WAN} -o ${LAN} -j ACCEPT

#https://forums.gentoo.org/viewtopic-t-918518-start-0.html

#!/bin/bash

#Set up some standard iptables rules
#Run as root

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set
iptables -I INPUT 2 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 600 --hitcount 5 -j DROP
iptables -A INPUT -j DROP

iptables -A OUTPUT -i lo -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -j DROP

iptables -L

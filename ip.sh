#!/bin/bash
iptables -F

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# ALLOW MIKE
iptables -A INPUT -i eth0 -s 192.168.23.11 -j ACCEPT

# ALLOW SCOREBOTS
iptables -A INPUT -p tcp -s 192.168.250.0/23 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.250.0/23 --dport 80 -j ACCEPT

# ALLOW ALL JUMP BOXES ALL TRAFFIC
iptables -A INPUT -s 192.168.23.192/25 -j ACCEPT

# ALLOW PING
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT

# DROP ALL
iptables -A INPUT -j DROP

iptables -L

# BACKUP IN CASE IT DOESNT WORK FOR JUMP BOXES
sleep 30

iptables -F

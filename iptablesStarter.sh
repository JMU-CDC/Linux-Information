#!/bin/bash

#Set up some standard iptables rules
#Run as root
# UNCOMMENT FOR YOUR BOX

# Rules for all boxes
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT

# AMAZON/SUSE
#iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
#iptables -A INPUT -s 192.168.23.11 -j ACCEPT

# Ubuntu 18 - linwks
#iptables -A INPUT -p tcp --dport 5900 -j ACCEPT
#iptables -A INPUT -p tcp --dport 5901 -j ACCEPT
#iptables -A INPUT -p tcp --dport 5902 -j ACCEPT
#iptables -A INPUT -p tcp --dport 5903 -j ACCEPT
#iptables -A INPUT -p tcp --dport 5904 -j ACCEPT

# UBUNTU 20 - prod - docker one - might not work be careful
#iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
#iptables -A INPUT -p tcp --dport 8888 -j ACCEPT
#iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --dport 8081 -j ACCEPT
#iptables -A INPUT -p tcp --dport 2375 -j ACCEPT
#iptables -A INPUT -s 192.168.23.12 -j ACCEPT
#iptables -A INPUT -s 192.168.23.80 -j ACCEPT

# RHEL 8
#iptables -A INPUT -p tcp --dport 2049 -j ACCEPT
#iptables -A INPUT -p tcp --dport 21 -j ACCEPT
#iptables -A INPUT -p tcp --dport 111 -j ACCEPT
#iptables -A INPUT -s 192.168.23.88 -j ACCEPT

iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
#sudo iptables -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 3 -j REJECT
#sudo iptables -A INPUT -p tcp --dport 80 -m limit --limit 20/s --limit-burst 200 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set
iptables -I INPUT 2 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 600 --hitcount 5 -j DROP

# DROP ALL
iptables -A INPUT -j DROP

iptables -L

# FAILSAFE IN CASE IT DOESNT WORK ON REMOTE BOX

sleep 30

iptables -F



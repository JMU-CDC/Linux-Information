#!/bin/bash

#Set up some standard iptables rules
#Run as root

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 8 -s 0/0 -d 127.0.0.1 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 0 -s 0/0 -d 127.0.0.1 -m state --state ESTABLISHED,RELATED -j ACCEPT
#sudo iptables -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 3 -j REJECT
#sudo iptables -A INPUT -p tcp --dport 80 -m limit --limit 20/s --limit-burst 200 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set
sudo iptables -I INPUT 2 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 600 --hitcount 5 -j DROP
sudo iptables -A INPUT -j DROP

#sudo iptables -A OUTPUT -i lo -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
#sudo iptables -A OUTPUT -j DROP

sudo iptables -L

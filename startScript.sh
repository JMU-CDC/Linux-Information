#!/bin/bash

echo "Current users on system"

who

mkdir ~/vbox

echo
echo "Copying /usr/bin and /usr/sbin..."

cp -R /usr/bin ~/vbox/usrBinBack
cp -R /usr/sbin ~/vbox/usrsSbinBack
cp -R /bin ~/vbox/binBack
cp -R /sbin ~/vbox/sbinBack
cp /etc/hosts ~/vbox/hosts
cp /etc/resolv.conf ~/vbox/resolv.conf

echo
echo "Done..."
echo
echo "Stoping cron service"

systemctl stop crond

echo
echo "Printing crontabs"
echo

ls /var/spool/cron
ls /var/spool/cron/crontabs
ls /etc/cron.d
echo "CHECK THESE FILES ^^^"

echo 'jimmu:VeRsiC@' | chpasswd
echo 'suizei:RoxiMl#' | chpasswd
echo 'annei:LAinyD$' | chpasswd
echo 'itoku:DELOwA!' | chpasswd
echo 'root:ERculT@' | chpasswd

echo 'kinmei:VeRsiC@' | chpasswd
echo 'bidatsu:RoxiMl#' | chpasswd
echo 'kotoku:LAinyD$' | chpasswd
echo 'yomei:DELOwA!' | chpasswd
echo 'sushun:ERculT@' | chpasswd

echo 'suiko:VeRsiC@' | chpasswd
echo 'jomei:RoxiMl#' | chpasswd
echo 'kogyoku:LAinyD$' | chpasswd
echo 'itoku:DELOwA!' | chpasswd
echo 'saimei:ERculT@' | chpasswd

echo 'tenji:VeRsiC@' | chpasswd
echo 'kobun:RoxiMl#' | chpasswd
echo 'jito:LAinyD$' | chpasswd
echo 'monmu:DELOwA!' | chpasswd
echo 'geme:ERculT@' | chpasswd


echo
echo
echo
echo "Creating backup user" 

useradd naruto
echo 'naruto:IdaveR#' | chpasswd
gpasswd -a naruto sudo


echo 
echo "Sudo Group users:"
echo

cat /etc/group | grep "sudo"

echo
echo "Sudoers permissions:"

cat /etc/sudoers | grep "ALL"

echo 
echo "Iptables Rules now"


iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT

# DROP ALL
iptables -A INPUT -j DROP

iptables -L


echo
echo "Fucking with firewall"
echo

cp /sbin/iptables /sbin/ipt
rm /sbin/iptables

echo 
echo "Aliases for current user:"

alias

echo
echo "All done.. Now go check /etc/ssh/sshd_config, your .bashrc file, printenv, update firewall if needed, and hope"







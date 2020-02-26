#!/bin/bash
#run with privilages

#set up cron file for root
touch /var/spool/cron/root
/usr/bin/crontab /var/spool/cron/root

echo "1 * * * * echo HELLO" >> /var/spool/cron/root

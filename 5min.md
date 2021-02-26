# Andy's 5 min plan for linux

## This isn't a solve all guide, each box is different but this is a good place to start

## Starting out
Right when I log onto a box the first thing that I check is if there are any other users logged in at the moment. 
* `Who` - Show current sessions on the system
* `last` - Show the last logins

These commands aren't perfect and a better way to find it is to look at the process tree.
* `ps faux | grep "bash"` - List all processes with bash, also good idea to do sh
* `pstree -n | grep "bash` - Same thing different command 

After that theres 2 other things I like to check quickly
* `alias` - list the alias
* `ls -l /bin | grep "Feb XX" 
The last command checks the last edited day of the binarys, if any look suspicious that shouldn't have been edited recently be careful.
Also do this on both /bin and /sbin

We'll come back to make backups later.

## Password time 
Quicky check files for immutability like /etc/password /etc/shadow /etc/group then CHANGE YOUR PASSWORD AND DONT FORGET ABOUT ROOT.
Having a password list beforehand is good.
Make a backup user now with admin privs.

## Check privs
Check out the passwd, group, sudoers, and sudoers.d files to find out some permissions on the system. Fix any that look bad please.

## Monitor those crontabs
Cron is a proccess that runs commands at a set time interval. 
* `crontab -l` - List crontabs for the user
* `crontab -r` - delete users crontabs 
Not perfect though, a weird user could have some so go to /var/spool/cron and check the directory for cron files. If any are bad remove them.
Also some cron files in /etc/cron.d /etc/cron.hourly /etc/cron.daily /etc/cron.weekly These files can be edited to run quicker so be careful.

## Check proccesses 
* `netstat -tulpa` - List all proccesses and the names, add 'n' to show port numbers

## Make a backup of system executables 
* `cp -R /bin /home/<user>/bin_backup` - Make a backup of the system executables, also need to do this with sbin. This way you can have a working version.

## Firewall
Build out your firewall and please don't lock yourself out.

## Check your SSH rules
These files are in /etc/ssh/

## Backup your networking files 
<MUST EDIT>
Arp table
Hostnames







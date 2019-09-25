# Andy's Random Linux Notes

## Table of Contents

1. [Users and Groups](#users-and-groups)
2. [Processes and Ports](#processes-and-ports)
    1. [netstat](#netstat)
    2. [A few Systemd commands](#a-few-systemd-commands)
3. [Random Helpful Commands](#random-helpful-commands)
       
## Users and Groups
When inteacting with user acounts on Linux you will need sudo privilages to make any changes. 
* Show all users: **cat /etc/passwd**
* Show all groups: **cat /etc/group**
* To add a user: **useradd 'name'**
* Remove a user: **userdel 'name'**
* Add user to a group: **gpasswd -a 'user' 'group'**
* Remove a user from a group: **gpasswd -d 'user' 'group'**
* To change a users Password: **passwd 'name'**

## Processes and Ports
When defending a linux machine it is important to know what processes and ports you have open, and how to start and stop them if required

### netstat
A great linux command that will give you insight into current network information.
* **netstat -p**: show the pid of all programs running
* **netstat -ntl**: Will show all open ports on your machine consicely
* **netstat -tulpan**: Show the PID for each network connection

### A few Systemd commands
* **systemctl status**: shows the process tree, great for finding extra bash sessions that shouldn't be there
* **systemctl start 'service'**: start a service, for example mysql
* **systemctl stop 'service'**: stop a service

## iptables
Firewall built into linux that helps limit traffic into your machine. The rules are put in in a list, the rules that come first are applied first
ACCEPT: Packet will be allowed to pass through
DROP: Packet will be dropped
LOG: Occurence will be logged

There are three chains that the rules can fall under:
INPUT: these rules apply to incoming traffic
FORWARD: These rules apply to traffic being forwarded
OUTPUT: these rules apply to outgoing traffic

* **iptables -L -v**: list all current rules, you can add --line-numbers to see the numbers assigned to the rules
* **iptables -F**: Flush all the rules from the table
* **iptables -D INPUT #**: delete the rule in INPUT at


### Some simple rules
The -A flag denotes what set of rules you are adding to. When using -A the rule is added at the end of the list. 
* **iptables -A INPUT -i lo ACCEPT**: This rule should be at the start of al the others. It allows all communication comming from the localhost to be validated. 
* **iptables -A INPUT -p 'tcp/udp' --dport 'port#' -j ACCEPT**: Accept all tcp or udp traffic from the port specified after --dport. If the desire is to drop all traffic from the port use DROP instead of ACCEPT.
* **iptables -A INPUT -s 'ip-address' -j DROP**: Drop all traffic coming from a certian IP address, if you want to block a whole ip range  replace "-s <ip" with "-m iprange --src-range 'ip'-'ip'".
* **iptables -A INPUT -j DROP**: drop everything else, in general you want to have this rule at the end of the list.


## Random Helpful Commands
* **watch -n 'seconds' 'command'**: repeats a commans every n seconds
* **who**: show current users who are logged in (great with watch)
* **last**: shows history of last users who logged in
* **ps faux**: another proccess tree view
* **apt-get update**: update the services on your machine
* **ls -lrb**: list files by the last time they were accessed 

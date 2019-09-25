# Andy's Random Linux Notes

## Table of Contents

1. [Users and Groups](#users-and-groups)
2. [Processes and Ports](#processes-and-ports)
    1. [netstat](#netstat)
    2. [A few Systemd commands](#a-few-systemd-commands)
3. [iptables](#iptables)
    1. [Important Commands](#important-commands)
    2. [Some simple rules](#some-simple-rules)
    3. [Andy's ruleset](#andy's-ruleset)
4. [Random Helpful Commands](#random-helpful-commands)
       
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
* ACCEPT: Packet will be allowed to pass through
* DROP: Packet will be dropped
* LOG: Occurence will be logged

There are three chains that the rules can fall under:
* INPUT: these rules apply to incoming traffic
* FORWARD: These rules apply to traffic being forwarded
* OUTPUT: these rules apply to outgoing traffic

### Important Commands
* **iptables -L -v**: list all current rules, you can add --line-numbers to see the numbers assigned to the rules
* **iptables -F**: Flush all the rules from the table
* **iptables -D INPUT #**: delete the rule in INPUT at
* **/sbin/iptables-save**: make changes persistent through reboots


### Some simple rules
The -A flag denotes what set of rules you are adding to. When using -A the rule is added at the end of the list. 
* **iptables -A INPUT -i lo ACCEPT**: This rule should be at the start of al the others. It allows all communication comming from the localhost to be validated. 
* **iptables -A INPUT -p 'tcp/udp' --dport 'port#' -j ACCEPT**: Accept all tcp or udp traffic from the port specified after --dport. If the desire is to drop all traffic from the port use DROP instead of ACCEPT.
* **iptables -A INPUT -s 'ip-address' -j DROP**: Drop all traffic coming from a certian IP address, if you want to block a whole ip range  replace "-s <ip" with "-m iprange --src-range 'ip'-'ip'".
* **iptables -A INPUT -j DROP**: drop everything else, in general you want to have this rule at the end of the list.
* **iptables -I INPUT # 'rule'** insert a rule at a certian position.

### Andy's ruleset
This ruleset will allow all localhost traffic, allow all ssh and http traffic, and will ban users for a certian time after a certian number of failed ssh attempts.
1. **iptables -A INPUT -i lo ACCEPT**: accept localhost traffic
2. **iptables -A INPUT -p tcp --dport 22 -j ACCEPT**: accept all ssh traffic
3. **iptables -A INPUT -p tcp --dport 80 -j ACCEPT**: accept all https traffic
4. **iptables -I INPUT 1 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set**: set up to ban bad attempts
5. **iptables -I INPUT 2 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 600 --hitcount 5 -j drop**: ban users for 600 seconds if they have 5 or more failed ssh attempts
6. **iptables -A INPUT -j DROP**: drop all other traffic

## Random Helpful Commands
* **watch -n 'seconds' 'command'**: repeats a commans every n seconds
* **who**: show current users who are logged in (great with watch)
* **last**: shows history of last users who logged in
* **ps faux**: another proccess tree view
* **apt-get update**: update the services on your machine
* **ls -lrb**: list files by the last time they were accessed 

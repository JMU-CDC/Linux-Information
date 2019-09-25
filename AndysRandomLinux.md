# Andy's Random Linux Notes

## Users and Groups
When inteacting with user acounts on Linux you will need sudo privilages to make any changes. 
* Show all users: **cat /etc/passwd**
* Show all groups: **cat /etc/group**
* To add a user: **useradd 'name'**
* Remove a user: **userdel 'name'**
* Add user to a group: **gpasswd -a 'user' 'group'**
* Remove a user from a group: **gpasswd -d 'user' 'group'**
* To change a users Password: **passwd 'name'**

## Proccesses and Ports
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

## Random Helpful Commands
* **watch -n 'seconds' 'command'**: repeats a commans every n seconds
* **who**: show current users who are logged in (great with watch)
* **last**: shows history of last users who logged in
* **ps faux**: another proccess tree view
* **apt-get update**: update the services on your machine
* **ls -lrb**: list files by the last time they were accessed 

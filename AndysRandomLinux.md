# Andy's Random Linux Notes

## Table of Contents

1. [Users and Groups](#users-and-groups)
2. [Processes and Ports](#processes-and-ports)
    1. [netstat](#netstat)
    2. [A Few Systemd Commands](#a-few-systemd-commands)
3. [iptables](#iptables)
    1. [Important Commands](#important-commands)
    2. [Some Simple Rules](#some-simple-rules)
    3. [Andy's Ruleset](#andys-ruleset)
4. [Random Helpful Commands](#random-helpful-commands)

## Users and Groups

When interacting with user accounts on Linux you will need sudo privilages to
make any changes.

* `less /etc/passwd`:  Show all users.
* `less /etc/group`: Show all groups.
* `useradd <name>`: Add a user.
* `userdel <name>`: Remove a user.
* `gpasswd -a <user> <group>`: Add user to a group.
* `gpasswd -d <user> <group>`: Remove a user from a group.
* `passwd <name>`: Change a user's password.

## Processes and Ports

When defending a Linux machine it is important to know what processes and ports
you have open, and how to start and stop them if required.

### netstat

A great Linux command that will give you insight into current network information.

* `netstat -p`: Show the pid of all processes running.
* `netstat -ntl`: Will show all open ports on your machine concisely.
* `netstat -tulpan`: Show the PID for each network connection.

### A Few Systemd Commands

* `systemctl status`: Shows the process tree. Great for finding extra bash
sessions that shouldn't be there.
* `systemctl start <service>`: Start a service. (e.g. MySQL).
* `systemctl stop <service>`: Stop a service.

## iptables

Firewall built into Linux that helps limit traffic into your machine. The rules
are put in in a list, the rules that come first are applied first.

* `ACCEPT`: Packet will be allowed to pass.
* `DROP`: Packet will be dropped.
* `LOG`: Occurrence will be logged.

There are three chains that the rules can fall under:

* `INPUT`: These rules apply to incoming traffic.
* `FORWARD`: These rules apply to traffic being forwarded.
* `OUTPUT`: These rules apply to outgoing traffic.

### Important Commands

* `iptables -L -v`: List all current rules. You can add `--line-numbers` to see
the numbers assigned to the rules.
* `iptables -F`: Flush all rules from the table.
* `iptables -D INPUT #`: Delete the specified rule number in `INPUT`.
* `/sbin/iptables-save`: Make changes persistent through reboots.

### Some Simple Rules

The `-A` flag denotes to which set of rules you are adding. When using `-A` the rule
is added at the end of the list.

* `iptables -A INPUT -i lo ACCEPT`: This rule should be at the start of all the
others. It allows all communication coming from the localhost to be validated.
* `iptables -A INPUT -p <tcp/udp> --dport <port#> -j ACCEPT`: Accept all TCP
or UDP traffic from the port specified after `--dport`. If the desire is to drop
all traffic from the port then use `DROP` instead of `ACCEPT`.
* `iptables -A INPUT -s <ip-address> -j DROP`: Drop all traffic coming from a
specified IP address. If you want to block a whole IP range then replace `-s <ip>`
with `-m iprange --src-range <ip>-<ip>`.
* `iptables -A INPUT -j DROP`: Drop everything else. In general you want to
have this rule at the end of the list.
* `iptables -I INPUT # <rule>`: Insert a rule at the specified position.

### Andy's Ruleset

This ruleset will allow all localhost traffic, allow all SSH and HTTP traffic,
and will ban users for a certain time after a certain number of failed SSH attempts.

1. `iptables -A INPUT -i lo ACCEPT`: Accept localhost traffic.
2. `iptables -A INPUT -p tcp --dport 22 -j ACCEPT`: Accept all SSH traffic.
3. `iptables -A INPUT -p tcp --dport 80 -j ACCEPT`: Accept all HTTP traffic.
4. `iptables -I INPUT 1 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent
 --set`: Ban bad attempts.
5. `iptables -I INPUT 2 -p tcp --dport 22 -i eth0 -m state --state NEW -m recent
 --update --seconds 600 --hitcount 5 -j drop`: Ban users for 600 seconds if they
 have five or more failed SSH attempts.
6. `iptables -A INPUT -j DROP`: Drop all other traffic

## Random Helpful Commands

* `watch -n <seconds> <command>`: Repeats a command every `n` second(s).
* `who`: Show currently logged in users (great with watch).
* `last`: Shows history of user logins and logouts.
* `ps faux`: Another process tree view.
* `apt-get` calls typically require root permissions:
  * `apt-get update`: Update the `apt` package lists to their latest versions.
  * `apt-get upgrade`: Upgrade your packages to the latest version, but do not
change what packages are installed.
  * `apt-get dist-upgrade`: Upgrade your packages to the latest version, including
installing or removing packages as needed to complete the upgrade.
* `ls -ltu`: List files by the last time they were accessed (most recent first).

#!/bin/ksh
#
cat help | while read user
do
        echo "Deleting: ${user}"
        echo userdel -r "${user}"
        userdel $user
done

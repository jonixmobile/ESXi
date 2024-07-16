#!/bin/bash
sshpass -p "pass" ssh -o StrictHostKeyChecking=no root@192.168.1.x vim-cmd vmsvc/get.summary 555 | grep toolsStatus |  awk -F '"' '{print $2}' >> vm1.status.log

file="vm1.status.log" #the file where you keep your string name

vm1=$(cat "$file")        #the output of 'cat $file' is assigned to the $name variable

echo $vm1


if [ "$vm1" = "toolsNotRunning" ]; then
    echo "Strings are equal."
    sshpass -p "pass" ssh -o StrictHostKeyChecking=no root@192.168.1.x vim-cmd vmsvc/power.reset 555
           /usr/bin/swaks --to mail@nosolovirtual.com --from "management@nosolovirtual.com" --server email-smtp.eu-west-1.amazonaws.com:587 -tls --auth PLAIN --auth-user "A" --auth-password "B" --header "Subject: Reset VM1" --body "Reset VM1"
#    sleep 40
    rm -rf vm1.status.log
else
    echo "Strings are not equal."
    rm -rf vm1.status.log
fi

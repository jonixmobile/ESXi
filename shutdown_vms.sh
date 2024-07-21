for p in $(  vim-cmd vmsvc/getallvms | awk '$1  { print $1 };');
do (vim-cmd vmsvc/power.shutdown $p &); done
sleep 30
poweroff

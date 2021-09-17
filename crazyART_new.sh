cd /proc
for dir in [1-9]*; do
    cmdline=`cat $dir/cmdline`
    if [[ $cmdline == *\.* ]] && [[ $cmdline != *\/* ]];
    then
        kill -USR1 $dir
    fi
done
sync
echo 1 > /proc/sys/vm/compact_memory
cat /proc/meminfo
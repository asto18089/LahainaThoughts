# Disable discard batching and make F2FS handle even the smallest GCable segment
echo 0 > /sys/fs/f2fs/dm-10/max_small_discards
echo 1 > /sys/fs/f2fs/dm-10/discard_granularity

# Enlarge the searching area of the victim segment, covering essentially the whole partition
echo 131072 > /sys/fs/f2fs/dm-10/max_victim_search

# Call gc_urgent and UFSHID in a loop, assuming the device mapper's number is 10.
# UFSHID is a shorthand for UFS Host Initiated Defrag, which probably means the Host(LAHAINA) will ask the device(UFS) to defrag?
# UFSHID is not supported on all UFS chips. Oneplus 9 Pro's SAMSUNG 3D-V5 F/W Ver 1903 support it, but F/W 1302 and F/W 090x do not.
a=0
while [ $a -lt 100 ]
do
    sync
    echo 1 > /sys/fs/f2fs/dm-10/gc_urgent
    echo 1 > /sys/devices/platform/soc/1d84000.ufshc/ufshid/trigger
    cat /sys/fs/f2fs/dm-10/moved_blocks_background
done
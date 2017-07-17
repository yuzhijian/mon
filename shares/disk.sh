#! /bin/bash
#对硬盘进行监控

rm -f ../log/disk.tmp
for r in `df -h |awk -F '[ %]+' '{print $5}'|grep -v Use`
do
    if [ $r -gt 60 ] && [ $send -eq "1" ]
then
    echo "$addr `date +%T` disk useage is $r" >>../log/disk.tmp
fi


if [ -f ../log/disk.tmp ]
then
    df -h >> ../log/disk.tmp
    /bin/bash ../mail/mail.sh $addr\_disk $r ../log/disk.tmp
    echo "`date +%T` disk useage is nook"
else
    echo "`date +%T` disk useage is ok"
fi


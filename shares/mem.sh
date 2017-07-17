#! /bin/bash
#本脚本记录系统的负载，如1分钟内的负载高于20就报警

mem=`free -m | grep "buffers" | tail -1 | awk -F" " '{print $4}'`
#截取当前的负载值
if [ $mem -lt 512 ] && [ $send -eq "1" ]
then
    echo "$addr `date +%T` mem is $mem" >../log/mem.tmp
    /bin/bash ../mail/mail.sh $addr\_mem $mem ../log/mem.tmp
fi
#如果当前负载值大于20，并且邮件有关为1，就发送邮件并记录在log/load.tmp

echo "`date +%T` mem is $mem"
#记录日值并发送到


#! /bin/bash
#本脚本记录系统的负载，如1分钟内的负载高于20就报警

load=`uptime |awk -F 'average:' '{print $2}'|cut -d',' -f1|sed 's/ //g' |cut -d. -f1`
#截取当前的负载值
if [ $load -gt 20 ] && [ $send -eq "1" ]
then
    echo "$addr `date +%T` load is $load" >../log/load.tmp
    /bin/bash ../mail/mail.sh $addr\_load $load ../log/load.tmp
fi
#如果当前负载值大于20，并且邮件有关为1，就发送邮件并记录在log/load.tmp

echo "`date +%T` load is $load"
#记录日值并发送到


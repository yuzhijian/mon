#! /bin/bash
#本脚本记录系统的负载，如1分钟内的负载高于20就报警

redis_live=`ps aux | grep "redis" | wc -l`
#截取当前的负载值
if [ $redis_live -lt 2 ] && [ $send -eq "1" ]
then
    echo "$addr `date +%T` redis_live is $redis_live" >../log/redis_live.tmp
    /bin/bash ../mail/mail.sh $addr\_redis_live $redis_live ../log/redis_live.tmp
fi
#如果当前负载值大于2，并且邮件有关为1，就发送邮件并记录在log/redis_live.tmp

echo "`date +%T` redis_live is $redis_live"
#记录日值并发送到


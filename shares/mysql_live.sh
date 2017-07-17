#! /bin/bash
#本脚本记录系统的负载，如1分钟内的负载高于20就报警

mysql_live=`ps aux | grep "mysql" | wc -l`
#截取当前的负载值
if [ $mysql_live -lt 2 ] && [ $send -eq "1" ]
then
    echo "$addr `date +%T` mysql_live is $mysql_live" >../log/mysql_live.tmp
    /bin/bash ../mail/mail.sh $addr\_mysql_live $mysql_live ../log/mysql_live.tmp
fi
#如果当前负载值大于2，并且邮件有关为1，就发送邮件并记录在log/mysql_live.tmp

echo "`date +%T` mysql_live is $mysql_live"
#记录日值并发送到


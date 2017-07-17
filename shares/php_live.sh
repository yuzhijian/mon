#! /bin/bash
#本脚本记录系统的负载，如1分钟内的负载高于20就报警

php_live=`ps aux | grep "php" | wc -l`
#截取当前的负载值
if [ $php_live -lt 2 ] && [ $send -eq "1" ]
then
    echo "$addr `date +%T` php_live is $php_live" >../log/php_live.tmp
    /bin/bash ../mail/mail.sh $addr\_php_live $php_live ../log/php_live.tmp
fi
#如果当前负载值大于2，并且邮件有关为1，就发送邮件并记录在log/php_live.tmp

echo "`date +%T` php_live is $php_live"
#记录日值并发送到


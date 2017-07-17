#! /bin/bash


d=`date -d "-1 min" +%H:%M`
#截取前一分钟的时间
c_403=`grep :$d:  $log  |grep '403'| wc -l`
#统计日志部分出现403的次数
if [ $c_403 -gt 10 ] && [ $send == 1 ]; then
     echo "$addr $d 403 count is $c_403">../log/403.tmp
     /bin/bash ../mail/mail.sh $addr\_403 $c_403  ../log/403.tmp
fi
#如果出现的次数大于10次，并且邮件开关为开启，就发送邮件。
#否则就记录日志/tmp/的下面。
echo "`date +%T` 403 $c_403"


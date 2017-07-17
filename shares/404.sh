! /bin/bash


d=`date -d "-1 min" +%H:%M`
#截取前一分钟的时间
c_404=`grep :$d:  $log  |grep '404'| wc -l`
#统计日志部分出现404的次数
if [ $c_404 -gt 10 ] && [ $send == 1 ]; then
     echo "$addr $d 404 count is $c_404">../log/404.tmp
     /bin/bash ../mail/mail.sh $addr\_404 $c_404  ../log/404.tmp
fi
#如果出现的次数大于10次，并且邮件开关为开启，就发送邮件。
#否则就记录日志/tmp/的下面。
echo "`date +%T` 404 $c_404"


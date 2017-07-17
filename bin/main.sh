#!/bin/bash


# 是否发送邮件的开关，当你不需要发邮件的时候，只需把send赋值设为非1就行了
export send=1


# 过滤ip地址
export addr=`/sbin/ifconfig |grep -A1 'eth0' |grep addr: |awk '{print $2}'|awk -F: '{print $2}'`


dir=`pwd`
# 只需要最后一级目录名
last_dir=`echo $dir|awk -F'/' '{print $NF}'`


# 下面的判断目的是，保证执行脚本的时候，我们在bin目录里，不然监控脚本、邮件和日志很有可能找不到
if [ $last_dir == "bin" ] || [ $last_dir == "bin/" ]; then
    conf_file="../conf/mon.conf"
else
    echo "you shoud cd bin dir"
    exit
fi


exec 1>>../log/mon.log 2>>../log/err.log


echo "`date +"%F %T"` load average"
/bin/bash ../shares/load.sh

echo "`date +"%F %T"` disk use"
/bin/bash ../shares/disk.sh

echo "`date +"%F %T"` mem use"
/bin/bash ../shares/mem.sh



#先检查配置文件中是否需要监控403
if grep -q 'to_mon_403=1' $conf_file; then
    export log=`grep 'logfile=' $conf_file |awk -F '=' '{print $2}' |sed 's/ //g'`
    /bin/bash  ../shares/403.sh
fi

#先检查配置文件中是否需要监控404
if grep -q 'to_mon_404=1' $conf_file; then
    export log=`grep 'logfile=' $conf_file |awk -F '=' '{print $2}' |sed 's/ //g'`
    /bin/bash  ../shares/404.sh
fi

#先检查配置文件中是否需要监控500
if grep -q 'to_mon_500=1' $conf_file; then
    export log=`grep 'logfile=' $conf_file |awk -F '=' '{print $2}' |sed 's/ //g'`
    /bin/bash  ../shares/500.sh
fi

#先检查配置文件中是否需要监控502
if grep -q 'to_mon_502=1' $conf_file; then
    export log=`grep 'logfile=' $conf_file |awk -F '=' '{print $2}' |sed 's/ //g'`
    /bin/bash  ../shares/502.sh
fi

#先检查配置文件中是否需要监控504
if grep -q 'to_mon_504=1' $conf_file; then
    export log=`grep 'logfile=' $conf_file |awk -F '=' '{print $2}' |sed 's/ //g'`
    /bin/bash  ../shares/504.sh
fi


#先检查配置文件中是否需要监控php
if grep -q 'to_mon_php_socket=1' $conf_file; then
    /bin/bash  ../shares/php_live.sh
fi

#先检查配置文件中是否需要监控nginx
if grep -q 'to_mon_nginx_socket=1' $conf_file; then
    /bin/bash  ../shares/nginx_live.sh
fi

#先检查配置文件中是否需要监控tomcat
if grep -q 'to_mon_tomcat_socket=1' $conf_file; then
    /bin/bash  ../shares/tomcat_live.sh
fi

#先检查配置文件中是否需要监控mysql
if grep -q 'to_mon_mysql_socket=1' $conf_file; then
    /bin/bash  ../shares/mysql_live.sh
fi

#先检查配置文件中是否需要监控redis
if grep -q 'to_mon_redis_socket=1' $conf_file; then
    /bin/bash  ../shares/redis_live.sh
fi


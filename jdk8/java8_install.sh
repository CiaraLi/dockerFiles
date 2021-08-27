#!/bin/bash

homeDir="/var/data/"
file="jdk-8u131.tar.gz "
 
check= `rpm -qa|grep java`
 if [ "$result" != "" ]
then
	echo "卸载旧版本   doing..." 
	rpm -qa|grep java | xargs   yum -y remove
	echo "OK..." 
fi

mkdir -p /usr/local/java
# 安装新版本  then
echo "开始安装Java8  doing..." 
cd  /usr/local/src
# 复制准备好的文件 
tar -zxvf  $homeDir$file  
mv ./jdk1.8.0_301  /usr/local/java/jdk8
# 备份
cp /etc/profile /etc/profile.bk.$(date +%F'-'%H'-'%M'-'%S)
# 环境变量
echo "export JAVA_HOME=/usr/local/java/jdk8"   >> /etc/profile
echo "export JRE_HOME=$JAVA_HOME/jre "   >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin "   >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"   >> /etc/profile
source /etc/profile
ln -s /usr/local/java/jdk8/bin/java /usr/bin/java
echo "Javay已成功安装至  /usr/local/java/jdk8 目录  OK ..." 

java -version

#!/bin/bash

homeDir="/var/data"
file="jdk-8u141-linux-x64.tar.gz"
jdk="jdk1.8.0_141"

 
check= `rpm -qa|grep java`
 if [ "$result" != "" ]
then
	echo "卸载旧版本   doing..." 
	rpm -qa|grep java | xargs   yum -y remove
	echo "OK..." 
fi

mkdir -p /usr/local/java
yum install -y  wget
# 安装新版本  then
echo "开始安装Java8  doing..." 
cd  $homeDir/src
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"   
# 复制准备好的文件 
tar -zxvf  $homeDir/src/$file  
mv ./$jdk  /usr/local/java/jdk8
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

rm -rf /var/data/src/*
yum remove -y wget

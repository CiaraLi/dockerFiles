#!/bin/bash

homeDir="/var/data"
file="jdk-11.0.12_linux-x64_bin.tar.gz"
jdk="jdk-11.0.12"

 
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
cd  $homeDir/src
# 复制准备好的文件 
tar -zxvf  $homeDir/src/$file  
mv ./$jdk  /usr/local/java/jdk11
# 备份
cp /etc/profile /etc/profile.bk.$(date +%F'-'%H'-'%M'-'%S)
# 环境变量
echo "export JAVA_HOME=/usr/local/java/jdk11"   >> /etc/profile
echo "export JRE_HOME=$JAVA_HOME/jre "   >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin "   >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"   >> /etc/profile
source /etc/profile
ln -s /usr/local/java/jdk11/bin/java /usr/bin/java
echo "Java已成功安装至  /usr/local/java/jdk11 目录  OK ..." 

java -version

rm -rf /var/data/src/*


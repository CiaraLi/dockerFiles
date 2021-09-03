#!/bin/bash
homeDir="/var/data" 
jdk="java8"
tomcat="tomcat"
webapp="webapp"
check= `rpm -qa|grep java`
#-----安装JDK  ------
# 卸载旧版本  
 if [ "$result" != "" ]
 then
	echo "卸载旧版本   doing..." 
	rpm -qa|grep java | xargs   yum -y remove
	echo "OK..." 
fi
cd  $homeDir/src
yum install -y  wget
# 安装新版本  then
mkdir -p /usr/local/java  
echo "开始安装Java8  doing..." 
# 复制准备好src 的文件jdk-8u141-linux-x64.tar.gz  或者在线下载
if [ !  -f  "$homeDir/src/jdk-8u141-linux-x64.tar.gz" ] 
then
	 wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"   
fi
# 复制准备好的文件 
tar -zxvf  $homeDir/src/jdk-8u141-linux-x64.tar.gz  
mv $homeDir/src/jdk1.8.0_141  /usr/local/java/$jdk
# 备份
cp /etc/profile /etc/profile.bk.$(date +%F'-'%H'-'%M'-'%S)
# 环境变量
echo "export JAVA_HOME=/usr/local/java/$jdk"   >> /etc/profile
echo "export JRE_HOME=$JAVA_HOME/jre "   >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin "   >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"   >> /etc/profile
source /etc/profile
ln -s /usr/local/java/$jdk/bin/java /usr/bin/java
echo "Java已成功安装至  /usr/local/java/$jdk 目录  OK ..." 
java -version
#----安装tomcat ------
# 复制准备好的文件apache-tomcat-10.0.10.tar.gz  或者在线下载 
if [ !   -f  "$homeDir/src/apache-tomcat-10.0.10.tar.gz" ]  
then
  wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.10/bin/apache-tomcat-10.0.10.tar.gz
fi
tar -zxvf  $homeDir/src/apache-tomcat-10.0.10.tar.gz 
mv $homeDir/src/apache-tomcat-10.0.10  /usr/local/$tomcat 
chmod +x /usr/local/$tomcat/bin/* 

#设置目录
mv /usr/local/$tomcat/webapps  $homeDir/webapps
ln -s $homeDir/webapps /usr/local/$tomcat/webapps
ln -s $homeDir/logs  /usr/local/tomcat/logs
echo "Tomcat已成功安装至：/usr/local/$tomcat 目录  
	  WebApp路径：$homeDir/webapp
	  前台运行： /usr/local/tomcat/bin/catalina.sh run
	  启动命令： /usr/local/tomcat/bin/catalina.sh start
	  停止命令： /usr/local/tomcat/bin/catalina.sh  stop
      OK ..."  
#删除安装包 
rm -rf  $homeDir/src/*
yum remove -y wget

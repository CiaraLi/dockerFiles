#!/bin/bash
#源码位置
homeDir="/usr/local"
#用户数据位置
userDir="/var/data"
tomcat="tomcat" 
jdk="java11" 
check= `rpm -qa|grep java`


# 卸载旧版本  
 if [ "$result" != "" ]
 then
	echo "卸载旧版本   doing..." 
	rpm -qa|grep java | xargs   yum -y remove
	echo "OK..." 
fi
cd  $homeDir/src
#创建Java目录
mkdir -p /usr/local/java 
# 安装新版本  then 
echo "开始安装Java11  doing..." 
 
# 复制准备好的文件 
tar -zxvf  $homeDir/src/jdk-11.0.12.tar.gz  
mv $homeDir/src/jdk-11.0.12  /usr/local/java/$jdk
# 备份
cp /etc/profile /etc/profile.bk.$(date +%F'-'%H'-'%M'-'%S)
# 环境变量
echo "export JAVA_HOME=/usr/local/java/$jdk"   >> /etc/profile
echo "export JRE_HOME=$JAVA_HOME/jre "   >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin "   >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"   >> /etc/profile
source /etc/profile
ln -s /usr/local/java/$jdk/bin/java  /usr/bin/java
echo "Java已成功安装至  /usr/local/java/$jdk 目录  OK ..." 
java -version

#----安装tomcat ------
# 复制准备好的文件apache-tomcat-9.0.60.tar.gz  或者在线下载 
cd  $homeDir/src 
tar -zxvf  $homeDir/src/apache-tomcat-9.0.60.tar.gz 
mv $homeDir/src/apache-tomcat-9.0.60  /usr/local/$tomcat 
chmod +x /usr/local/$tomcat/bin/* 

#设置目录
mv /usr/local/$tomcat/webapps  $userDir/webapps
ln -s $userDir/webapps /usr/local/$tomcat/webapps 
mv /usr/local/$tomcat/logs  $userDir/logs
ln -s $userDir/logs  /usr/local/tomcat/logs
echo "Tomcat已成功安装至：/usr/local/$tomcat 目录  
	  WebApp路径：$userDir/webapps
	  前台运行： /usr/local/tomcat/bin/catalina.sh run
	  启动命令： /usr/local/tomcat/bin/catalina.sh start
	  停止命令： /usr/local/tomcat/bin/catalina.sh  stop
      OK ..."  
 
#------设置账号和服务  提前在src 下面 准备好tomcat-users.xml  server.xml 文件 
if [ ! -f  "$homeDir/src/tomcat-users.xml" ]  
then
  	echo ""
else
	rm  -f /usr/local/$tomcat/conf/tomcat-users.xml  && cp $homeDir/src/tomcat-users.xml  /usr/local/$tomcat/conf/ 
fi
if [ ! -f  "$homeDir/src/server.xml" ]  
then
  	echo ""
else
	rm  -f   /usr/local/$tomcat/conf/server.xml && cp $homeDir/src/server.xml       /usr/local/$tomcat/conf/
fi
if [ ! -f  "$homeDir/src/manager.xml" ]  
then
  	echo ""
else
	mkdir -p   /usr/local/$tomcat/conf/Catalina/localhost/ && cp    $homeDir/src/manager.xml      /usr/local/$tomcat/conf/Catalina/localhost/
fi
rm -rf  $homeDir/src/* 

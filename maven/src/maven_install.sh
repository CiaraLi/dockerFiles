#!/bin/bash
homeDir="/var/data" 
jdk="java8"
tomcat="tomcat"
webapp="webapp" 
 
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
rm -rf  $homeDir/src/* 

#!/bin/bash
homeDir="/usr/local/"
tomcat="tomcat" 
 
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

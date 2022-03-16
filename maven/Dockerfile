#镜像源
FROM  iongdoc/tomcat

RUN  mkdir -p /var/data;\
mkdir -p /usr/local/tomcat/conf/Catalina/localhost;
COPY  ./src/manager.xml      /usr/local/tomcat/conf/Catalina/localhost/manager.xml
COPY  ./src/server.xml       /usr/local/tomcat/conf/server.xml
COPY  ./src/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

#数据卷 默认，可以在run时重新指定目录  
VOLUME ["/var/data/webapps/logs/","/var/data/webapps"]
#声明开放端口，需要在run时做映射
EXPOSE 8088
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]


# 构建 docker build -t maven ./ 
# 启动命令 docker run -itd -v /home/www-data/java/webapps:/var/data/webapps -v /home/www-data/java/logs/:/var/data/logs/ -p 8080:8088  --name maven maven  
# 访问地址 ： http://127.0.0.1:8080/
 
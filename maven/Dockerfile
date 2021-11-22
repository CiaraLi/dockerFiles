#镜像源
FROM tomcat 
COPY  ./src/*  /usr/local/src/

RUN rm -f /etc/localtime && ln -sf  /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ;\
echo "set encoding=utf-8" > ~/.vimrc;\
mkdir -p /var/data;\
/bin/chmod +x /usr/local/src/maven_install.sh;\
/usr/local/src/maven_install.sh;

#数据卷 默认，可以在run时重新指定目录  
VOLUME ["/usr/local/tomcat/logs/","/usr/local/tomcat/webapps/"]
#声明开放端口，需要在run时做映射
EXPOSE 8088
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]
# 构建 docker build -t maven ./ 
# 启动命令 docker run -itd -v /home/www-data/java/webapps/:/usr/local/tomcat/webapps/ -v  /home/www-data/www_logs/:/usr/local/tomcat/logs/ -p 8080:8088  --name hello maven  
 
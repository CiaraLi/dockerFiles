#镜像源
FROM iongdoc/centos7
#安装JAVA
WORKDIR /var/data 
COPY  ./src/* ./src/
RUN /bin/chmod +x ./src/tomcat_install.sh;\
    ./src/tomcat_install.sh;\
    yum clean all;
#数据卷 默认，可以在run时重新指定目录
VOLUME ["/var/data/logs/"]
#声明开放端口，需要在run时做映射
EXPOSE 8080 
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]


# 构建 docker build -t tomcat ./
# 启动命令 docker run -itd   -p 8080:8080  --name tomcat11  tomcat11  
# docker run -itd  -v /home/www-data/java/webapps:/var/data/webapps -v /home/www-data/java/logs/:/var/data/logs/ -p 8080:8080  --name tomcat11   tomcat11 
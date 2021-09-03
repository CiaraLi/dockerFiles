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


#镜像源
FROM iongdoc/centos7
#安装JAVA
WORKDIR /var/data 
COPY  ./src/* ./src/
RUN ./src/java8_install.sh;\
    yum clean all;
#数据卷
VOLUME ["/var/logs/"]
CMD ["date"]

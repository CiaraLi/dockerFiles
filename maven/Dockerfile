#镜像源
FROM iongdoc:tomcat
COPY  ./src/* ./src/
RUN /bin/chmod +x ./src/maven_install.sh;\
    ./src/maven_install.sh;\
    yum clean all;
#数据卷 默认，可以在run时重新指定目录 
#声明开放端口，需要在run时做映射
EXPOSE 8088
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]

#  docker run -itd --name tomcat -p 8080:8088  iongdoc/tomcat 


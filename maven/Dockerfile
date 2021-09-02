#镜像源
FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;\
rm -f /etc/localtime && ln -sf  /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ;\
echo "Hello  Centos --Ciara--"  > /etc/motd ; \
echo "set encoding=utf-8" > ~/.vimrc;\
mkdir -p /var/data;

#安装JAVA
WORKDIR /var/data 
COPY  ./src/* ./src/
RUN /bin/chmod +x ./src/tomcat_install.sh;\
    ./src/tomcat_install.sh;\
    yum clean all;
#数据卷 默认，可以在run时重新指定目录
#VOLUME ["/sys/fs/cgroup","/var/data/logs/","/var/data/webapps/"]
#声明开放端口，需要在run时做映射
#EXPOSE 8088
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]

#  docker run -itd -v /home/www-data/java/webapps:/var/data/webapps --name tomcat -p 8080:8088  iongdoc/tomcat 


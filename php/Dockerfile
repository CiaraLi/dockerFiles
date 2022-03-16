#镜像源
FROM  php:7.4.27
#安装JAVA
WORKDIR /var/data 
COPY  ./src/* ./src/
RUN rm -f /etc/localtime && ln -sf  /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ;\
	echo "set encoding=utf-8" > ~/.vimrc;\
	mkdir -p /var/data;\
    /bin/chmod +x /usr/local/src/php_install.sh;\
    /usr/local/src/php_install.sh;\
	yum clean all;
#数据卷
VOLUME ["/var/logs/"]
CMD ["date"]

# docker build -t php7 ./

#镜像源
FROM php
#安装JAVA
WORKDIR /var/data 
COPY  ./src/* ./src/
RUN rm -f /etc/localtime && ln -sf  /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ;\
	echo "set encoding=utf-8" > ~/.vimrc;\
	mkdir -p /var/data;\
	yum clean all;
#数据卷
VOLUME ["/var/logs/"]
CMD ["date"]

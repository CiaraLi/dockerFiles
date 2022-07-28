FROM centos:7
USER root

LABEL MAINTAINER="<ciara@gmail.com>"

COPY src/  /tmp/

## isntall nginx by source code 
WORKDIR /tmp

ENV TZ=Asia/Shanghai
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
	echo "--HELLO  PHP7.3--"  > /etc/motd ; \
	echo "set encoding=utf-8" > ~/.vimrc; \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone ;\
	chmod +x php_install.sh && ./php_install.sh  
	  
	 

EXPOSE 80 443
VOLUME  ["/home/www-data","/usr/local/nginx/conf/include"]
CMD ["/bin/sh","/start.sh","daemon off;"]

# 构建 docker build -t php7 ./ 
# 启动命令 docker run -itd -v /Users/tal/docker/php/config:/usr/local/nginx/conf/include -v /Users/tal/docker/php/www-data/:/home/www-data/ -p 80:80  --name php7  php7  
# 访问地址 ： http://127.0.0.1:8080/

#直接使用镜像
# export LOCALDIR=/Users/tal/docker/php 
# docker run -itd -v {$LOCALDIR}/config:/usr/local/nginx/conf/include -v {$LOCALDIR}/www-data/:/home/www-data/ -p 80:80  --name work  iongdoc/php7.3 
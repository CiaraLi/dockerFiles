#!/bin/bash 


# install relay
yum -y  install  epel-release   wget    php-pear  autoconf gcc-c++  
wget -O /etc/yum.repos.d/CentOS-Base-aliyun.repo http://mirrors.aliyun.com/repo/Centos-6.repo
yum clean all
/etc/yum.repos.d/
yum -y  install  libxml2 libxml2-devel  openssl openssl-devel bzip2 bzip2-devel  oniguruma  oniguruma-devel  
yum -y  install  libcurl  libcurl-devel   libjpeg libjpeg-devel libevent libpng libpng-devel  freetype freetype-devel 
yum -y  install  gmp gmp-devel  libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel gd gd-devel 

groupadd -r www-data
useradd www-data -g www-data -s /sbin/nologin  
		
# install nginx
cd /tmp && tar -zxvf nginx-1.18.0.tar.gz 
cd /tmp/nginx-1.18.0
./configure --user=nginx --group=nginx --prefix=/usr/local/nginx
make && make install

mkdir -p /home/www-data  /home/www_logs  /usr/local/nginx/conf/include 
mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back
mv /tmp/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf
mv /tmp/nginx/start.sh /start.sh
chmod +x /start.sh
mv /tmp/nginx/default.conf /usr/local/nginx/conf/include/default.conf
mv /tmp/www-data /home/www-docker  
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/
/usr/local/nginx/sbin/nginx -t
	
#install php
cd /tmp && tar -zxvf php-7.3.5.tar.gz
cd /tmp/php-7.3.5
./configure --prefix=/usr/local/php \
	    --enable-fpm \
	    --with-fpm-user=www-data \
	    --with-fpm-group=www-data \
	    --enable-inline-optimization \
	    --enable-debug \
		--without-sqlite3 \
		--without-pdo_sqlite \
	    --disable-rpath \
	    --enable-shared \
	    --enable-soap \
	    --with-xmlrpc \
	    --with-openssl \
	    --with-mhash \
	    --with-zlib \
	    --enable-bcmath \
	    --with-iconv \
	    --with-iconv-dir=/usr/local/libiconv \
	    --with-bz2 \
	    --enable-calendar \
	    --with-curl \
	    --with-cdb \
	    --enable-dom \
	    --enable-exif \
	    --enable-fileinfo \
	    --enable-filter \
	    --enable-ftp \
	    --with-openssl-dir \
	    --with-gettext \
	    --with-gmp \
	    --with-mhash \
	    --enable-json \
	    --enable-mbstring \
	    --enable-mbregex \
	    --enable-pdo \
	    --with-mysqli=mysqlnd \
	    --with-pdo-mysql=mysqlnd \
	    --with-zlib-dir \
	    --with-readline \
	    --enable-session \
	    --enable-shmop \
	    --enable-simplexml \
	    --enable-sockets \
	    --enable-sysvmsg \
	    --enable-sysvsem \
	    --enable-sysvshm \
	    --with-xsl \
	    --enable-mysqlnd-compression-support \
	    --with-pear \
	    --enable-opcache\
make && make install 

mv /tmp/php/php-fpm.conf /usr/local/php/etc/php-fpm.conf 
mv /tmp/php/www.conf /usr/local/php/etc/php-fpm.d/www.conf 
mv /tmp/php/php.ini /usr/local/php/lib/php.ini 
ln -s /usr/local/php/sbin/php-fpm /usr/local/bin/ 
ln -s /usr/local/php/bin/php  /usr/local/bin/  
php -v 


# install phpredis
cd /tmp && tar -zxvf phpredis-4.0.2.tar.gz 
cd /tmp/phpredis-4.0.2	
/usr/local/php/bin/phpize  
./configure --with-php-config=/usr/local/php/bin/php-config 
make && make install 
rm -rf /tmp
yum clean all	

whoami  >>/whoami.txt


	
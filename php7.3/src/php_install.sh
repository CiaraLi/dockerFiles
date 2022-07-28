#!/bin/bash 

homeDir="/tmp" 
php="php-7.3.5"
phpDir="/usr/local/php"
nginx="nginx-1.18.0"  
nginxDir="/usr/local/nginx"  
phpredis="phpredis-4.0.2"   

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
cd ${homeDir} && tar -zxvf ${nginx}.tar.gz 
cd ${homeDir}/${nginx}
./configure --user=nginx --group=nginx --prefix=${nginxDir}
make && make install

mkdir -p /home/www-data  /home/www_logs  ${nginxDir}/conf/include 
mv  ${nginxDir}/conf/nginx.conf  ${nginxDir}/conf/nginx.conf.back
mv  ${homeDir}/nginx/nginx.conf  ${nginxDir}/conf/nginx.conf
mv  ${homeDir}/nginx/start.sh /start.sh
chmod +x /start.sh
mv  ${homeDir}/nginx/default.conf ${nginxDir}/conf/include/default.conf
mv  ${homeDir}/www-data /home/www-docker  
ln -s ${nginxDir}/sbin/nginx /usr/local/bin/
${nginxDir}/sbin/nginx -t
	
#install php
cd ${homeDir} && tar -zxvf ${php}.tar.gz
cd ${homeDir}/${php}
./configure --prefix=${phpDir} \
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

mv  ${homeDir}/php/php-fpm.conf ${phpDir}/etc/php-fpm.conf 
mv  ${homeDir}/php/www.conf ${phpDir}/etc/php-fpm.d/www.conf 
mv  ${homeDir}/php/php.ini  ${phpDir}/lib/php.ini 
ln -s ${phpDir}/sbin/php-fpm /usr/local/bin/ 
ln -s ${phpDir}/bin/php  /usr/local/bin/  
php -v 


# install phpredis
cd ${homeDir} && tar -zxvf ${phpredis}.tar.gz 
cd ${homeDir}/${phpredis}	
${phpDir}/bin/phpize  
./configure --with-php-config=${phpDir}/bin/php-config 
make && make install 
rm -rf  ${homeDir}
yum clean all


	
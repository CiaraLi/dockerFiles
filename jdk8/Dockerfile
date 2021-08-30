FROM base

RUN rm -f /etc/localtime && ln -sf  /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ;\
echo "Hello  Centos --Ciara--"  > /etc/motd ; \
echo "set encoding=utf-8" > ~/.vimrc;\
mkdir -p /var/data/src;

WORKDIR /var/data 
COPY  ./src/* ./src/
VOLUME ["/var/logs"]
CMD ["./src/java8_install.sh"]

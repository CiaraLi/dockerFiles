#镜像源
FROM golang

#安装JAVA
WORKDIR /var/data 
COPY ./src/main.go ./ 

#数据卷
VOLUME ["/var/logs/","/var/data"]

EXPOSE 8088

CMD ["go" ,"run","main.go"]

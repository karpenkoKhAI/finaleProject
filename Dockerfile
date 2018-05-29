#Get based OSf
FROM ubuntu:latest
MAINTAINER EPAM DevOps course
#USER root
#RUN groupadd docker && gpasswd -a jenkins docker 
COPY nginx_build.sh /tmp
ARG NGINX_VERSION=1.11.0
ARG NGINX_MODULE_TYPE=-dynamic
#Update image
RUN apt-get update -y && apt-get upgrade -y
#Install nginx
RUN cd /tmp && sh /tmp/nginx_build.sh && rm -rf /tmp/*
WORKDIR /etc/nginx
VOLUME ["/var/log/nginx", "/var/www/html"]
#Replace standart nginx.conf
RUN rm /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx
#Replace standart index.html
#RUN rm /var/www/html/index.nginx-debian.html
ADD index.html /var/www/html/
#Run nginx on 80 port
#EXPOSE 80
#Run nginx server on docker 
#CMD ["nginx", "-g", "daemon off;"]

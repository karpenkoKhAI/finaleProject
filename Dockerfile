
FROM ubuntu:16.04

MAINTAINER epam epam@epam.com

COPY build.sh /tmp

ARG NGINX_VERSION=1.11.0

ARG NGINX_MODULE_TYPE=-dynamic

ARG NGINX_DEBUG


RUN cd /tmp && sh /tmp/build.sh && rm -rf /tmp/*

WORKDIR /etc/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /etc/nginx/html/index.html

EXPOSE 80 443 8080

VOLUME ["/var/log/nginx", "/var/www/html"]

#CMD sh
CMD ["nginx", "-g", "daemon off;"]


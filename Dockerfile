
FROM ubuntu:16.04

COPY build.sh /tmp

ARG NGINX_VERSION=1.11.0

# Use -dynamic or blank
ARG NGINX_MODULE_TYPE=-dynamic

# To build with debug version set value as 1 during build
ARG NGINX_DEBUG


RUN cd /tmp && sh /tmp/build.sh && rm -rf /tmp/*

WORKDIR /etc/nginx

EXPOSE 80 443 8080

VOLUME ["/var/log/nginx", "/var/www/html"]

#CMD sh
CMD ["nginx", "-g", "daemon off;"]


#!/bin/bash
apt-get update -y
apt-get upgrade -y
 apt-get install -y curl build-essential make gcc libpcre3 libpcre3-dev libpcre++-dev zlib1g-dev libbz2-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libssl-dev libcurl4-openssl-dev wget unzip make libssl-dev libpcre3-dev gcc make zlib1g-dev

wget http://nginx.org/download/nginx-1.9.12.tar.gz

tar xvf nginx-1.9.12.tar.gz

cd nginx-1.9.12/

./configure \
--prefix=/etc/nginx                                                \
--sbin-path=/usr/sbin/nginx                                        \
--conf-path=/etc/nginx/nginx.conf                                  \
--error-log-path=/var/log/nginx/error.log                          \
--http-log-path=/var/log/nginx/access.log                          \
--pid-path=/var/run/nginx.pid                                      \
--lock-path=/var/run/nginx.lock                                    \
--http-client-body-temp-path=/var/cache/nginx/client_temp          \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp                 \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp             \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp                 \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp                   \
--user=nginx                                                       \
--group=nginx                                                      \
--with-http_ssl_module                                             \
--with-http_realip_module                                          \
--with-http_addition_module                                        \
--with-http_sub_module                                             \
--with-http_dav_module                                             \
--with-http_flv_module                                             \
--with-http_mp4_module                                             \
--with-http_gunzip_module                                          \
--with-http_gzip_static_module                                     \
--with-http_random_index_module                                    \
--with-http_secure_link_module                                     \
--with-http_stub_status_module                                     \
--with-http_auth_request_module                                    \
--with-mail                                                        \
--with-mail_ssl_module                                             \
--with-file-aio                                                    \
--with-http_v2_module                                              \
--with-ipv6                                                        \
--with-threads                                                     \
--with-stream                                                      \
--with-stream_ssl_module                                           \
--with-http_slice_module

make
 make install

 useradd -r nginx
 mkdir /var/cache/nginx
 touch /var/cache/nginx/client_temp

service nginx start

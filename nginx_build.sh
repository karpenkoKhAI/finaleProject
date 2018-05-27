#!/bin/bash
#Install 
apt-get install -y wget unzip make libssl-dev libpcre3-dev gcc make zlib1g-dev >> /dev/null
#Download source code function
downloadAndExtract()
{
    TARGET_URL=$1
    FILENAME=$2
    FOLDER=$3
    EXTRACT=$4
    
    if [ ! -d $FOLDER ]; then
        mkdir -p $FOLDER
    fi

    if [ ! -d $EXTRACT ]; then
        mkdir -p $EXTRACT
    fi

    if [ ! -f "$FOLDER/$FILENAME" ]; then
       wget --quiet  --force-directories --output-document="$FOLDER/$FILENAME" $TARGET_URL
    fi

    if [ ! -z "$EXTRACT" ]; then
        case $FILENAME in
          *.zip) unzip -q -o -d "$EXTRACT" "$FOLDER/$FILENAME";;
          *.tar.gz) tar xf "$FOLDER/$FILENAME" -C "$EXTRACT";;
          *) echo "Error file format";;
        esac

        FILECOUNT=$(ls -al $EXTRACT | wc -l | tr " " "\0")
        if [ "$FILECOUNT" = "4" ]; then
           FOLDER_NAME=$(ls $EXTRACT | tr " " "\0")
           mv $EXTRACT/$FOLDER_NAME/* $EXTRACT/
           rm -rf $EXTRACT/$FOLDER_NAME
        fi
    fi
}
#Variables 
LUA_JIT_VERSION=${LUA_JIT_VERSION:-2.0.4}
NGINX_VERSION=${NGINX_VERSION:-1.11.3}
NGINX_DEVEL_VERSION=${NGINX_DEVEL_VERSION:-v0.3.0}

NGINX_MODULE_TYPE=${NGINX_MODULE_TYPE:-}

LUA_JIT_FILE=LuaJIT-${LUA_JIT_VERSION}.tar.gz
NGINX_FILE=nginx-$NGINX_VERSION.tar.gz
NGINX_DEVEL_FILE=nginx_devel_kit_${NGINX_DEVEL_VERSION}.tar.gz

LUA_JIT_URL=http://luajit.org/download/LuaJIT-${LUA_JIT_VERSION}.tar.gz
NGINX_URL=http://nginx.org/download/$NGINX_FILE
NGINX_DEVEL_URL=https://github.com/simpl/ngx_devel_kit/archive/${NGINX_DEVEL_VERSION}.tar.gz


LUA_CJSON_FILE=lua_cjson.zip
LUA_CJSON_URL=https://github.com/efelix/lua-cjson/archive/master.zip

LUA_MAIN_URL=https://github.com/openresty/lua-nginx-module/archive/master.zip
LUA_MAIN_FILE=lua-nginx-module.zip

LUA_KAFKA_URL=https://github.com/doujiang24/lua-resty-kafka/archive/master.zip
LUA_KAFKA_FILE=lua-resty-kafka.zip

LUA_SYSLOG_URL=https://gitlab.com/lsyslog/lsyslog/repository/archive.zip?ref=master
LUA_SYSLOG_FILE=lua-syslog.zip

LUA_ECHO_URL=https://github.com/openresty/echo-nginx-module/archive/master.zip
LUA_ECHO_FILE=lua-echo.zip

#Downloads and extract
downloadAndExtract $NGINX_URL $NGINX_FILE downloads extracts/nginx-${NGINX_VERSION}
downloadAndExtract $NGINX_DEVEL_URL $NGINX_DEVEL_FILE downloads extracts/modules/ngx_devel_kit

downloadAndExtract $LUA_CJSON_URL $LUA_CJSON_FILE downloads extracts/deps/lua_cjson
downloadAndExtract $LUA_SYSLOG_URL $LUA_SYSLOG_FILE downloads extracts/deps/lua-syslog

downloadAndExtract $LUA_MAIN_URL $LUA_MAIN_FILE downloads extracts/modules/lua-nginx-module
downloadAndExtract $LUA_ECHO_URL $LUA_ECHO_FILE downloads extracts/modules/lua-echo-module

download_extract $LUA_JIT_URL $LUA_JIT_FILE downloads extracts/deps/luajit

#Make lua
make -C extracts/deps/luajit install

export LUAJIT_LIB=/usr/local/lib 
export LUAJIT_INC=/usr/local/include/luajit-2.0
export LUA_INCLUDE_DIR=$LUAJIT_INC
export LUA_LIB_DIR=$LUAJIT_LIB

make -C extracts/deps/lua_cjson

cd extracts/nginx-${NGINX_VERSION}

LUAJIT_LIB=/usr/local/lib LUAJIT_INC=/usr/local/include/luajit-2.0 \
./configure \
--user=nginx                          \
--group=nginx                         \
--prefix=/etc/nginx                   \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--lock-path=/var/run/nginx.lock       \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module        \
--with-http_stub_status_module        \
--with-http_ssl_module                \
--with-pcre                           \
--with-file-aio                       \
--with-http_realip_module             \
--without-http_scgi_module            \
--without-http_uwsgi_module           \
--without-http_fastcgi_module ${NGINX_DEBUG:+--debug} \
--with-cc-opt=-O2 --with-ld-opt='-Wl,-rpath,/usr/local/lib' \
--add${NGINX_MODULE_TYPE}-module=$PWD/../modules/ngx_devel_kit \
--add${NGINX_MODULE_TYPE}-module=$PWD/../modules/lua-nginx-module \
--add${NGINX_MODULE_TYPE}-module=$PWD/../modules/lua-echo-module

make -j 4 # Stream

make install

#Create user
getent group nginx || groupadd nginx
getent user nginx || useradd -g nginx --system --no-create-home nginx

nginx -t


























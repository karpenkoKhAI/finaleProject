#Get based OS
FROM ubuntu:lates
MAINTAINER EPAM DevOps course
#Update image
RUN apt-get update -y && apt-get upgrade -y
#Install nginx
RUN apt-get install nginx -y
#Replace standart nginx.conf
RUN rm /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx
#Run nginx on 80 port
EXPOSE 80
#Run nginx server on docker 
CMD["nginx","-g","daemon off;"]

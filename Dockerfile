#Get based OS
FROM ubuntu:lates
MAINTAINER EPAM DevOps course
#Update image
RUN sudo apt-get update -y && sudo apt-get upgrade -y
#Install nginx
RUN sudo apt-get install nginx -y
#Replace standart nginx.conf
RUN sudo rm /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx
#Run nginx on 80 port
EXPOSE 80
#Run nginx server on docker 
CMD["nginx","-g","daemon off;"]

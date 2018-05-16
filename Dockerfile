FROM ubuntu:lates

MAINTAINER EPAM DevOps course

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install nginx -y

EXPOSE 80

CMD["nginx","-g","daemon off;"]

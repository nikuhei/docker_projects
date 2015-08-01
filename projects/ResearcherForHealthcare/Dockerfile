FROM centos

MAINTAINER NIkuhei

RUN yum update -y

ADD nginx.repo /etc/yum.repos.d/
RUN yum install -y nginx

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

FROM centos:latest
MAINTAINER shenyushun

RUN yum install wget -y
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
RUN yum makecache 
RUN yum update -y
RUN yum install httpd -y
RUN yum install -y openssh openssh-server
RUN echo 'root:asdasd' |chpasswd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key

RUN yum install -y python-devel python-setuptools python-setuptools-devel
RUN easy_install pip
RUN pip install supervisor

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf


EXPOSE 22 80
CMD ["/usr/bin/supervisord"]

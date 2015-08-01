FROM centos

MAINTAINER NIkuhei

RUN yum -y update

#Dev tools for all Docker
RUN yum -y install git vim

RUN yum -y install passwd openssh openssh-server openssh-clients sudo


# create user

RUN useradd nikuhei
RUN passwd -f -u nikuhei
RUN mkdir -p /home/nikuhei/.ssh;chown nikuhei /home/nikuhei/.ssh; chmod 700 /home/nikuhei/.ssh
ADD ./docker_ssh/authorized_keys /home/nikuhei/.ssh/authorized_keys
RUN chown nikuhei /home/nikuhei/.ssh/authorized_keys;chmod 600 /home/nikuhei/.ssh/authorized_keys

# setup sudoers
RUN echo "nikuhei ALL=(ALL) ALL" >> /etc/sudoers.d/nikuhei

# setup sshd
ADD ./docker_ssh/sshd_config /etc/ssh/sshd_config
RUN /etc/init.d/sshd start;/etc/init.d/sshd stop

# expose for sshd
EXPOSE 2222

CMD ["/usr/sbin/sshd","-D"]

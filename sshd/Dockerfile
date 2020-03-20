FROM centos7:v1
MAINTAINER wangzhanbiao1@gmail.com
RUN yum -y update
RUN yum install -y openssh-server openssh
# Config SSH
#Modify the root password
RUN echo "root:root" | chpasswd
RUN mkdir -p /var/run/sshd
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
#RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
# SSH login fix. Otherwise user is kicked off after login
RUN sed -i '/^session\s\+required\s\+pam_loginuid.so/s/^/#/' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
EXPOSE 22
#ADD run.sh /usr/sbin/run.sh
#RUN chmod 755 /usr/sbin/run.sh
CMD ["/usr/sbin/sshd" , "-D"]

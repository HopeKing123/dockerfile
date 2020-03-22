FROM sshd:new
MAINTAINER wangzhanbiao1@gmail.com
#Base package
RUN yum -y update && yum clean all
RUN yum install -y gcc gcc-c++ make libtool zlib zlib-devel pcre pcre-devel openssl openssl-devel wget lrzsz net-tools  libaio* numactl
RUN yum install -y epel-release && yum clean all
RUN yum install -y supervisor
ENV LC_ALL en_US.UTF-8
COPY mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz /usr/src/mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz
COPY mysql.sh /usr/local/bin/mysql.sh
RUN chmod 755 /usr/local/bin/mysql.sh
RUN sh /usr/local/bin/mysql.sh
EXPOSE 22 3306
VOLUME ["/usr/local/mysql/"]
COPY supervisord.conf /etc/supervisord.conf
ENTRYPOINT ["/usr/bin/supervisord"]

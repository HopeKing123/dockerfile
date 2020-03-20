FROM sshd:new
MAINTAINER wangzhanbiao1@gmail.com
#Base package
RUN yum -y update && yum clean all 
RUN yum install -y gcc gcc-c++ make libtool zlib zlib-devel pcre pcre-devel openssl openssl-devel wget lrzsz net-tools 
RUN yum install -y epel-release && yum clean all
RUN yum install -y supervisor
#Install nginx
ADD nginx-1.14.2.tar.gz /usr/local/src/
RUN groupadd nginx && useradd -g nginx nginx -s /bin/false
WORKDIR /usr/local/src/nginx-1.14.2
RUN ./configure --prefix=/usr/local/nginx \
     --with-http_dav_module --with-http_stub_status_module \
     --with-http_addition_module --with-http_sub_module \
     --with-http_flv_module --with-http_mp4_module --with-pcre \
     --with-http_ssl_module --with-http_gzip_static_module \
     --user=nginx --group=nginx && make && make install
RUN ln -s /usr/local/nginx/sbin/* /usr/local/sbin/
RUN cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.old
RUN echo "daemon off;" >> /usr/local/nginx/conf/nginx.conf
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#EXPOSE port
EXPOSE 22 80 443
#storage
VOLUME [ "/usr/share/nginx/html/" ]
#Shell
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]

#!/bin/bash
USER=`groupadd -r mysql && useradd -r -g mysql -s /bin/false -M mysql`
rpm -qa | grep mariadb > /dev/null
if [ $? -eq 0 ]
then
	rpm -e mariadb-libs --nodeps
fi
$USER
cd /usr/src/
tar zxf mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz
mv mysql-5.7.24-linux-glibc2.12-x86_64 /usr/local/mysql
cd /usr/local/mysql
mkdir data
chown -R mysql.mysql ./
ln -s /usr/local/mysql/bin/* /usr/local/bin 
cat << EOF >> /etc/my.cnf
[mysqld]
basedir=/usr/local/mysql/
datadir=/usr/local/mysql/data
socket=/usr/local/mysql/mysql.sock
pid-file=/usr/local/mysql/data/mysqld.pid
log-error=/usr/local/mysql/data/mysql.err
log-bin=mysql-bin
server-id=1
[client]
socket=/usr/local/mysql/mysql.sock
EOF
mysqld --initialize --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
/etc/init.d/mysqld start
if [ $? -eq 0 ]
	then
	MYSQL=`grep password /usr/local/mysql/data/mysql.err | awk -F  "root@localhost: " '{print $2}'`
	 mysql -uroot -p${MYSQL} --connect-expired-password <<EOF
        alter user root@localhost identified by '12345678';
        exit
EOF
	#/etc/init.d/mysqld start
fi

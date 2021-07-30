#!/bin/bash

source common.sh

PRINT "Install Redis Repos"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
STAT_CHECK $?

PRINT "Install Redis\t"
yum install redis -y --enablerepo= remi &>>$LOG
STAT_CHECK $?

PRINT "Update Redis Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
STAT_CHECK $?

PRINT "Start Redis Service"
systemctl enable redis &>>$LOG && systemctl start redis &>>$LOG
STAT_CHECK $?
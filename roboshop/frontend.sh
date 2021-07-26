#!/bin/bash

source common.sh

PRINT "Installing Nginx\t"
yum install nginx -y  &>>$LOG
STAT_CHECK $?

PRINT "Download Frontend\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
STAT_CHECK $?

PRINT "Remove Old HtDocs\t"
cd /usr/share/nginx/html &>>$LOG && rm -rf * &>>$LOG
STAT_CHECK $?

PRINT "Extract Frontend Archive"
unzip /tmp/frontend.zip &>>$LOG && mv frontend-main/* . &>>$LOG && mv static/* . &>>$LOG && rm -rf frontend-master static &>>$LOG
STAT_CHECK $?

PRINT "Copy Roboshop Config\t"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
STAT_CHECK $?

PRINT "Update Roboshop Config"
sed -i -e  '/catalogue/ s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
STAT_CHECK $?

PRINT "Enabling Nginx\t\t"
systemctl enable nginx &>>$LOG
STAT_CHECK $?

PRINT "Starting Nginx\t\t"
systemctl start nginx  &>>$LOG
STAT_CHECK $?

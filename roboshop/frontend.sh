#!/bin/bash

LOG=/tmp/roboshop.log
echo -e "Installing Nginx\t\t...\t\e[32mdone\e[0m"
yum install nginx -y  >>$LOG
## 1."Output from command should not be displayed on screen"
## 2. "Validate the command is successful or not"


echo "Enabling Nginx"
systemctl enable nginx >>$LOG

echo "Starting Nginx"
systemctl start nginx  >>$LOG
#!/bin/bash

LOG=/tmp/roboshop.log
rm -f $LOG

echo -n -e "Installing Nginx\t\t..."
yum install nginx -y  &>>$LOG
if [$? -eq 0]; then
  echo done
else
  echo fail
fi
## 1. Output from command should not be displayed on screen
## 2. Validate the command is successful or not
## 3. Need to validate whether the script is running as root user or not

echo "Enabling Nginx"
systemctl enable nginx &>>$LOG
echo $?

echo "Starting Nginx"
systemctl start nginx  &>>$LOG
echo $?

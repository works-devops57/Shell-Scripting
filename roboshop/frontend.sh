#!/bin/bash

source common.sh

PRINT "Installing Nginx"
yum install nginx -y  &>>$LOG
STAT_CHECK $?

## 1. Output from command should not be displayed on screen
## 2. Validate the command is successful or not
## 3. Need to validate whether the script is running as root user or not

PRINT "Enabling Nginx\t"
systemctl enable nginx &>>$LOG
STAT_CHECK $?

PRINT "Starting Nginx\t"
systemctl start nginx  &>>$LOG
STAT_CHECK $?

#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
  echo -e "\e[31m You Should be root user/sudo to run this script\e[0m"
  exit 2
fi

LOG=/tmp/roboshop.log
rm -f $LOG

STAT_CHECK() {
  if [ $1 -eq 0 ]; then
  echo -e "\e[32m done\e[0m"
else
  echo -e "\e[32m fail\e[0m"
  echo -e "\e[33m Check the log file for more details, Log File - $LOG\e[0m"
  exit 1
fi
}

PRINT() {
  echo -e "\n########################\t$1\t########################" &>>$LOG
  echo -n -e "$1\t\t..."
}

NODEJS() {
  PRINT "Install NodeJS\t\t"
  yum install nodejs make gcc-c++ -y &>>$LOG
  STAT_CHECK $?

  PRINT "Add Roboshop Application User"
  id roboshop &>>$LOG
  if [ $? -ne 0 ]; then
   useradd roboshop &>>$LOG
  fi
  STAT_CHECK $?

  PRINT "Download Application Code"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
  STAT_CHECK $?

  PRINT "Extract Downloaded Code\t"
  cd /home/roboshop && unzip -o /tmp/${COMPONENT}.zip &>>$LOG && rm -rf ${COMPONENT} && mv ${COMPONENT}-main ${COMPONENT}
  STAT_CHECK $?

  PRINT "Install NodeJS Dependencies"
  cd /home/roboshop/${COMPONENT} && npm install --unsafe-perm &>>$LOG
  STAT_CHECK $?

  PRINT "Fix Application Permisssions"
  chown roboshop:roboshop /home/roboshop -R &>>$LOG
  STAT_CHECK $?

  PRINT "Setup SystemD file\t"
  sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" /home/roboshop/${COMPONENT}/systemd.service && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
  STAT_CHECK $?

  PRINT "Start ${COMPONENT} Service\t"
  systemctl daemon-reload &>>$LOG && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  STAT_CHECK $?
}
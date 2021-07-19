#!/bin/bash

echo -e "Installing Nginx\t\t...\tdone"
yum install nginx -y

echo "Enabling Nginx"
systemctl enable nginx

echo "Starting Nginx"
systemctl start nginx
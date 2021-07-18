#!/bin/bash

A=10
echo  A= $A
DATE="2021-07-18"
echo Welcome, Today date is $DATE



# Command Subs
NO_OF_USERS=$(who |wc -l)
echo Numbers of Users= $NO_OF_USERS

# Date with command substitution
DATE=$(date +%F)
echo Welcome, Today date is $DATE




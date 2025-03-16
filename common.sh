#!/bin/bash

set -e

handle_error(){
    echo "Error occured at line number: $1, error command: $2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


VALIDATE(){
if [ $1 -ne 0 ]
then 
    echo -e "$2 is $R Failure $N"
    exit 1
else
    echo -e "$2 is $G success $N"
    fi
}

check_root(){
if [ $USERID -ne 0 ]
then 
    echo "Please run with root user"
    exit 1
else
    echo "You are a root user"
fi
}



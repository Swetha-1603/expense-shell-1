#!/bin/bash

sourse ./common.sh

check_root

echo "Pleae enter DB password"
read -s Mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing Mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling Mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "starting mysql server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up root password"


#Below code will be useful for idempotent nature
mysql -h db.swetha.store -uroot -p${Mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${Mysql_root_password} &>>$LOGFILE
    VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi

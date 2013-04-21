#/bin/sh

mysql -u root -ppassword -e "create database mtgdb"
mysql -u root -ppassword -e "create user 'mtgdb'@'localhost' identified by 'password';"
mysql -u root -ppassword -e "grant all privileges on mtgdb.* to 'mtgdb'@'localhost';"

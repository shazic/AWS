#!/bin/bash
yum update -y
yum install httpd -y
chmod  o+w /var/www/html
echo "<h1>Hello</h1>Welcome to AWS" > /var/www/html/index.html
service httpd start
chkconfig httpd on
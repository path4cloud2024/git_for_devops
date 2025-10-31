
# RECOMMENDATION IS USE SQLITE (which is simple, light and fast)

# install mysql
apt update
apt install mariadb-server -y

# reload systemd and start the service if not running
systemctl daemon-reload
systemctl status mariadb

# create DB & user:

mysql -e "CREATE DATABASE gitea;"
mysql -e "CREATE USER 'gitea'@'localhost' IDENTIFIED BY 'path4cloud@2025';"
mysql -e "GRANT ALL PRIVILEGES ON gitea.* TO 'gitea'@'localhost';"

# then set in installer

#Host: 127.0.0.1:3306
#User: gitea
#Password: path4cloud@2025
#DB: gitea



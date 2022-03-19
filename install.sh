#!/bin/sh  -- vi apm.sh


sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
sudo dpkg --configure -a 
apt-get update; apt-get upgrade -y
sudo apt install ssh -y
sudo apt install vim -y
sudo apt install net-tools -y
sudo apt install vsftpd -y
sudo apt install mariadb-server libapache2-mod-php7.4 -y
sudo apt install php7.4-gd php7.4-json php7.4-mysql php7.4-curl php7.4-mbstring  php-fpm -y
sudo apt install php7.4-intl php-imagick php7.4-xml php7.4-zip php7.4-bcmath php7.4-gmp -y
sudo apt install phpmyadmin -y
cp -av /etc/php/7.4/fpm/php.ini /etc/php/7.4/fpm/php.ini.original
sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php/7.4/fpm/php.ini
sed -i 's/expose_php = On/expose_php = Off/' /etc/php/7.4/fpm/php.ini
sed -i 's/display_errors = Off/display_errors = On/' /etc/php/7.4/fpm/php.ini
sed -i 's/;error_log = php_errors.log/error_log = php_errors.log/' /etc/php/7.4/fpm/php.ini
sed -i 's/error_reporting = E_ALL \& ~E_DEPRECATED/error_reporting = E_ALL \& ~E_NOTICE \& ~E_DEPRECATED \& ~E_USER_DEPRECATED/' /etc/php/7.4/fpm/php.ini
sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/' /etc/php/7.4/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 100M/' /etc/php/7.4/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' /etc/php/7.4/fpm/php.ini
sed -i 's/;date.timezone =/date.timezone = "Asia\/Seoul"/' /etc/php/7.4/fpm/php.ini
sed -i 's/session.gc_maxlifetime = 1440/session.gc_maxlifetime = 86400/' /etc/php/7.4/fpm/php.ini
sed -i 's/disable_functions =/disable_functions = system,exec,passthru,proc_open,popen,curl_multi_exec,parse_ini_file,show_source/' /etc/php/7.4/fpm/php.ini
sed -i 's/allow_url_fopen = On/allow_url_fopen = Off/' /etc/php/7.4/fpm/php.ini
sed -i 's/bind-address = 127.0.0.1 /#bind-address = 127.0.0.1 /' /etc/mysql/mariadb.conf.d/50-server.cnf
apt-get -y install php-ssh2 -y

apt-get -y install udisks2-btrfs -y


echo "<VirtualHost *:80>
    ServerName 192.168.219.146
    ServerAlias 192.168.219.146

    DocumentRoot /home/intro

    <Directory /home/*>
        Options FollowSymLinks MultiViews
        AllowOverride All
        require all granted
    </Directory>

    ErrorLog /var/log/error_log
    CustomLog /var/log/access_log common

</VirtualHost>" >> /etc/apache2/sites-available/192.168.219.146.conf

ln -s /etc/apache2/sites-available/192.168.219.146.conf /etc/apache2/sites-enabled/192.168.219.146.conf
sudo apt install python3-certbot-apache -y
a2ensite 192.168.219.146.conf -y
a2enmod rewrite
sudo apt -y install cockpit

sudo systemctl start cockpit


#아파치 restart
systemctl restart apache2

echo "write_enable=YES
      local_umask=022" >> /etc/vsftpd.conf

service vsftpd restart

echo "<?php
phpinfo();
?>" >> /home/intro/index.php

echo "tar -czpf /home/backup/miscell.`date +%Y%m%d%H%M%S`.tgz /home/miscell 1>/dev/null 2>/dev/null
tar -czpf /home/backup/fmput.`date +%Y%m%d%H%M%S`.tgz /home/fmput 1>/dev/null 2>/dev/null
tar -czpf /home/backup/sunyoung.`date +%Y%m%d%H%M%S`.tgz /home/sunyoung 1>/dev/null 2>/dev/null
tar -czpf /home/backup/nasf.`date +%Y%m%d%H%M%S`.tgz /home/nasf 1>/dev/null 2>/dev/null
tar -czpf /home/backup/sline.`date +%Y%m%d%H%M%S`.tgz /home/sline 1>/dev/null 2>/dev/null
tar -czpf /home/backup/chamjuk.`date +%Y%m%d%H%M%S`.tgz /home/chamjuk 1>/dev/null 2>/dev/null
tar -czpf /home/backup/remiz.`date +%Y%m%d%H%M%S`.tgz /home/remiz 1>/dev/null 2>/dev/null
tar -czpf /home/backup/rokits.`date +%Y%m%d%H%M%S`.tgz /home/rokits 1>/dev/null 2>/dev/null
tar -czpf /home/backup/conf.`date +%Y%m%d%H%M%S`.tgz /etc/apache2/sites-available 1>/dev/null 2>/dev/null
#tar -czpf /home/backup/nextcloud.`date +%Y%m%d%H%M%S`.tgz /var/www/html/nextcloud 1>/dev/null 2>/dev/null
tar -czpf /home/backup/nextcloud.`date +%Y%m%d%H%M%S`.tgz /var/www/html/nextcloud | split -b 4096m 1>/dev/null 2>/dev/null
tar -czpf /home/backup/root.`date +%Y%m%d%H%M%S`.tgz /var/www/html/root 1>/dev/null 2>/dev/null
tar -czpf /home/backup/letsencrypt.`date +%Y%m%d%H%M%S`.tgz /etc/letsencrypt 1>/dev/null 2>/dev/null
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 fmput > /home/backup/fmput.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 remiz > /home/backup/remiz.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 miscell > /home/backup/miscell.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 sline > /home/backup/sline.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 introgq > /home/backup/introgq.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 webend > /home/backup/webend.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 chamjuk > /home/backup/chamjuk.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 rokits > /home/backup/rokits.`date +%Y%m%d%H%M%S`.sql
#mysqldump --extended-insert=FALSE -uroot -p!Speeds0119 bo > /home/backup/bo.`date +%Y%m%d%H%M%S`.sql
find /home/backup/ -type f -mtime +10 | sort | xargs rm -f
#ncftpput -u "data" -p"introsi" nas.rokits.xyz /home/data/server /home/backup/*
ncftpput -u "admin" -p"inst2020119#" remiz.ipdisk.co.kr /HDD2/server /home/backup/*
#ncftpput -u "admin" -p"introsi" 192.168.219.115 /VOLUME2/LGSERVER /home/backup/*
#ncftpput -u "remiz" -p"introsi" rokits.xyz /home/intro /home/backup/*
#rm -rf /home/backup/*" >> /root/backup.sh
chmod 700 /root/backup.sh
chown intro.intro /home/intro/index.php
sudo apt-get upgrade -y
mysql

SELECT user,host,plugin,authentication_string FROM mysql.user;
set password = password("!Speeds0119");
use mysql;
update user set plugin='mysql_native_password' where user='root';
set password = password("!Speeds0119");
flush privileges;
SELECT user,host,plugin,authentication_string FROM mysql.user;

exit




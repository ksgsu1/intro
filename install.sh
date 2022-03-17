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
sudo apt install python3-certbot-apache
a2ensite 192.168.219.146.conf -y
a2enmod rewrite

#아파치 restart
systemctl restart apache2

echo "write_enable=YES
      local_umask=022" >> /etc/vsftpd.conf

service vsftpd restart

echo "<?php
phpinfo();
?>" >> /home/intro/index.php

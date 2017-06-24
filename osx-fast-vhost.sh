#!/bin/bash

echo -n "Enter the production URL for this website > "
read prodDomain
echo "You entered: $prodDomain"
echo -n "Enter your local URL for development > "
read localurl
echo "Your Local URL is: $localurl"

##Creates Virtual Host
echo "<VirtualHost *:80>
    DocumentRoot '/Library/WebServer/Documents/GIT/$prodDomain'
    ServerName $localurl
        <Directory '/Library/WebServer/Documents/GIT/$prodDomain'>
                Options Indexes FollowSymLinks
                AllowOverride All
                Order allow,deny
                Allow from all
        </Directory>
</VirtualHost>" >> /private/etc/apache2/extra/httpd-vhosts.conf

##Sets up host configuration
echo "127.0.0.1     $localurl" >> /private/etc/hosts

echo [password] | sudo -S apachectl restart
echo [password] | sudo mkdir /Library/WebServer/Documents/GIT/$prodDomain
echo "<?php phpinfo(); ?>" >> /Library/WebServer/Documents/GIT/$prodDomain/index.php

echo "Successfully Setup $localurl - Build something cool"

(/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-speech-input $localurl) &

return

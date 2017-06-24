# osx-fast-virtual-hosts

## About

Like many others, I work on dozens of different websites throughout the week. I wanted to simplify the process of creating VirtualHosts for apache.

Please review the source and information before running on your machine.

## Environment

OS X 10.12.4
Apache/2.4.25 (Unix)

## Configuration

Feel free to adapt to your configuration and workflow.  Upon execution you'll be prompted for a 'production URL' and a 'local URL'.  You should run this bash script by executing as your systems root user `sudo ./add/correct/path/to/osx-fast-vhost.sh`  

Assuming that you're developing on a local webserver the script will use these input variables to:
   Configure a `<VirtualHost>` directive in apache's **httpd-vhosts.conf**,
   Update the machines **hosts** file (/private/etc/hosts),
   Restart Apache,
   Creates the DocumentRoot directory,
   Generates an index.php file that contains a call to `phpinfo()`,
   Launches Google Chrome and loads the local URL specified in the beginning.

Once you review the source of the script and confirm that it is properly configured for your environments paths, remember to update lines 25 & 26.

> echo [password] | sudo -S apachectl restart
> echo [password] | sudo mkdir /Library/WebServer/Documents/GIT/$prodDomain

Replace [password] with your admin/root user's password.  I suppose you could ask users to supply their password when running the script, if anyone has suggestions for improvements feel free to change it.

## Set Permissions

Make sure the script is executable `chmod a+x /path/to/osx-fast-vhost.sh`

## Running

I add the script in my $PATH so I can easily execute it.  Alternatively you can execute the script by typing `sudo ./add/correct/path/to/osx-fast-vhost.sh` in your terminal.

## Source

> #!/bin/bash
>
> echo -n "Enter the production URL for this website > "
> read prodDomain
> echo "You entered: $prodDomain"
> echo -n "Enter your local URL for development > "
> read localurl
> echo "Your Local URL is: $localurl"
>
> ##Creates Virtual Host
> echo "<VirtualHost *:80>
>    DocumentRoot '/Library/WebServer/Documents/GIT/$prodDomain'
>    ServerName $localurl
>        <Directory '/Library/WebServer/Documents/GIT/$prodDomain'>
>                Options Indexes FollowSymLinks
>                AllowOverride All
>                Order allow,deny
>                Allow from all
>        </Directory>
> </VirtualHost>" >> /private/etc/apache2/extra/httpd-vhosts.conf
>
>##Sets up host configuration
> echo "127.0.0.1     $localurl" >> /private/etc/hosts
> 
> echo [password] | sudo -S apachectl restart
> echo [password] | sudo mkdir /Library/WebServer/Documents/GIT/$prodDomain
> echo "<?php phpinfo(); ?>" >> /Library/WebServer/Documents/GIT/$prodDomain/index.php
> 
> echo "Successfully Setup $localurl - Build something cool"
>
> (/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-speech-input $localurl) &
>
> return

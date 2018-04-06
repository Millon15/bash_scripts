#!/bin/bash
ln -s ~/Library/Containers/MAMP/manager-osx.app ~/Desktop/MAMP
ln -s ~/Library/Containers/MAMP/apache2/htdocs ~/Desktop/htdocs
sed -i -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' ~/Library/Containers/MAMP/php/etc/php.ini

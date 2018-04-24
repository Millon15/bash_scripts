#!/bin/bash

ln -s $HOME/Library/Containers/MAMP/manager-osx.app $HOME/Desktop/MAMP
ln -s $HOME/Library/Containers/MAMP/apache2/htdocs $HOME/Desktop/htdocs
mkdir -p $HOME/http/MyWebSite
sed -i -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' ~/Library/Containers/MAMP/php/etc/php.ini

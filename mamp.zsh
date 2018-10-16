#!/bin/bash

# $MAMP=~/Library/Containers/MAMP
CONFF="$MAMP/apache2/conf/bitnami/bitnami.conf"
INCMSG='Include "/Users/vbrazas/http/main.conf"'

if [[ $1 == "-l" ]]; then
	echo "Creating MAMP aliases and new folder: ~/http/MyWebSite"
	rm -f $HOME/Desktop/MAMP $HOME/Desktop/htdocs
	ln -s $MAMP/manager-osx.app $HOME/Desktop/MAMP
	ln -s $MAMP/apache2/htdocs $HOME/Desktop/htdocs
	mkdir -p $HOME/http/MyWebSite
fi
if [[ $1 == "" || $1 == "-l" ]]; then
	echo "Turnng off MAMP backend caching and correcting bitnami.conf"
	sed -i -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' $MAMP/php/etc/php.ini
	if [[ $(tail -n 1 $CONFF) != $INCMSG ]]; then
		echo $INCMSG >> $CONFF
	fi
fi
if [[ $1 == "-r" ]]; then
	rm -rf $MAMP
	echo "Folder $MAMP has been removed"
fi
if [[ $1 == "-i" ]]; then
	open $HOME/Downloads/bitnami-mampstack-7.1.22-1-osx-x86_64-installer.dmg
fi

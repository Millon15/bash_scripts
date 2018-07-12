#!/bin/bash

#### ~/Library/Containers/MAMP
MAMPP="$HOME/Library/Containers/MAMP"
SCRIPTP="$HOME/projects/bash_scripts/mamp.sh"


if [[ $1 == "-l" ]]; then
	echo "Creating MAMP aliases and new folder: ~/http/MyWebSite"
	ln -s $MAMPP /manager-osx.app $HOME/Desktop/MAMP
	ln -s $MAMPP/apache2/htdocs $HOME/Desktop/htdocs
	mkdir -p $HOME/http/MyWebSite
fi
if [[ $1 == "-r" ]]; then
	rm -rf $MAMPP
	echo "Folder $MAMPP has been removed"
fi
if [[ $1 == "-c" ]]; then
	cat $SCRIPTP
fi
if [[ $1 == "-i" ]]; then
	open $HOME/Downloads/bitnami-mampstack-7.1.16-0-osx-x86_64-installer.dmg
fi
if [[ $1 == "-v" ]]; then
	vim $HOME/projects/bash_scripts/mamp.sh
fi
if [[ $1 == "" || $1 == "-l" ]]; then
	echo "Turnng off MAMP backend caching and correcting bitnami.conf"
	sed -i -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' $MAMPP/php/etc/php.ini
	echo 'Include "/Users/vbrazas/http/main.conf"' >> $MAMPP/apache2/conf/bitnami/bitnami.conf
fi

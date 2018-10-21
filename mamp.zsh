#!/bin/bash

MAMP=$HOME/Library/Containers/MAMP
CONFF="$MAMP/apache2/conf/bitnami/bitnami.conf"
INCMSG="Include \"$HOME/http/main.conf\""

put_usage() {
	echo "Usage: mamp [-i] [-l] [-r] [-h]"
	echo "Default installiation directory: $MAMP"
	echo "mamp -i : launch instaliation drive"
	echo "mamp -l : makes aliases on Desktop and add additional include strings to bitnami.conf file"
	echo "mamp -r : remove the '$MAMP' folder"
	echo "mamp -h : call help reference"
	exit 1;
}

if [[ $1 == "-l" ]]; then
	echo "Creating MAMP aliases and new folder: ~/http/MyWebSite"
	rm -f $HOME/Desktop/MAMP $HOME/Desktop/htdocs
	ln -s $MAMP/manager-osx.app $HOME/Desktop/MAMP
	ln -s $MAMP/apache2/htdocs $HOME/Desktop/htdocs
	mkdir -p $HOME/http/MyWebSite
	echo "Turnng off MAMP backend caching and correcting bitnami.conf"
	sed -i -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' $MAMP/php/etc/php.ini
	if [[ $(tail -n 1 $CONFF) != $INCMSG ]]; then
		echo $INCMSG >> $CONFF
	fi
elif [[ $1 == "-r" ]]; then
	rm -rf $MAMP
	echo "Folder $MAMP has been removed"
	echo "Default installiation directory: $MAMP"
elif [[ $1 == "-i" ]]; then
	open $HOME/Downloads/bitnami-mampstack-7.1.22-1-osx-x86_64-installer.dmg
elif [[ $1 == "-h" || $1 == "--help" || $2 || "$*" == "" ]]; then
	put_usage
else
	put_usage
fi

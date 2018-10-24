#!/bin/bash

MAMP=$HOME/Library/Containers/MAMP
CONFF="$MAMP/apache2/conf/bitnami/bitnami.conf"
IMAIN="Include \"$HOME/http/main.conf\""
IMATCHA="Include \"$HOME/http/matcha.conf\""

put_usage() {
	echo "Usage: mamp [-i] [-l] [-r] [-h] [--re]"
	echo "Default installiation directory: $MAMP"
	echo "mamp -i : launch instaliation drive"
	echo "mamp -l : makes aliases on Desktop and setup my custom MAMP environment"
	echo "mamp -r : remove the '$MAMP' folder"
	echo "mamp -h : call help reference"
}

if [[ $1 == "-l" ]]; then
	echo "Creating MAMP aliases and new folder: $HOME/http/MyWebSite"
	rm -f $HOME/Desktop/MAMP
	ln -s $MAMP/manager-osx.app $HOME/Desktop/MAMP
	mkdir -p $HOME/http/MyWebSite
	echo "Turning off MAMP backend caching and correcting $MAMP/apache2/conf/bitnami/bitnami.conf"
	sed -i "" -e 's/opcache.revalidate_freq=60/opcache.revalidate_freq=0/g' -e 's/\;sendmail_path/sendmail_path/' $MAMP/php/etc/php.ini
	if [[ ! $(grep "$IMAIN" $CONFF) ]]; then
		echo $IMAIN >> $CONFF
	fi
	if [[ ! $(grep "$IMATCHA" $CONFF) ]]; then
		echo $IMATCHA >> $CONFF
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

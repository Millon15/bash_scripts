#!/bin/bash

# Remove script
#### You have to be in the folder, that contains the directories to remove ####
BIP="$HOME/.bin"

remove()
{
	echo "Removing to ${BIP}/"
	if [ ! -d "${BIP}/" ];
		then
			mkdir ${BIP}/
	fi
	if [ -d "${BIP}/$*/" ] || [ -f "${BIP}/$*" ];
		then
			rm -rf ${BIP}/$*
	fi
	if [ -f $* ];
		then
			mv $* ${BIP}/
		else
			mkdir -p ${BIP}/$*
			if [ -n "$(ls -A $*/)" ];
				then
					mv $*/* ${BIP}/$*/
					rm -rf $*/
				else
					rm -rf $*/
			fi
	fi
}

alias re=remove

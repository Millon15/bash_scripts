#!/bin/bash

#### Remove script
#### You have to be in the folder, that contains the directories to remove ####
BIP="$HOME/.Trash/"

remove()
{
	echo "Removing to ${BIP}"
	for arg do
		rm $BIP$arg
		mv $arg $BIP
	done;
}
alias re=remove
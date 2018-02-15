#!/bin/bash

##Path of the code.desktop file, which we need to replace

C_PATH="/usr/share/applications/code.desktop"

vsc_icon_replace()
{
	if [ -f $C_PATH ];
		then
			echo "Replacing original code.desktop by $HOME/icons/code.desktop"
			sudo cp $HOME/icons/code.desktop $C_PATH
		else
			echo "There is no original code.desktop, so nothing to replace"
	fi
}

alias vsres=vsc_icon_replace

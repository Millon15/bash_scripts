#!/bin/bash

# Google Drive for Ubuntu

GPATH="$HOME/google_drive"

gmount()
{
	if [ ! -d ${GPATH} ];
		then
			mkdir ${GPATH}
		else
			rm -rf ${GPATH}
			mkdir ${GPATH}
	fi
	google-drive-ocamlfuse ~/google_drive
}

unmountg()
{
	if [ -d ${GPATH} ]
		then
			fusermount -u ${GPATH}
			rm -rf ${GPATH}
	fi
}

alias gm=gmount
alias unmg=unmountg
alias unm='fusermount -u'
alias gdr=google-drive-ocamlfuse

# When you’re finished editing, adding or copying files you can unmount the fuse filesystem with this command: fusermount -u ~/google_drive



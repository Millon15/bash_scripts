#!/bin/bash

#### Backup scripts
#### You have to be in the folder, that contains the directories to backup
BPATH="$HOME/backups"	# For sucsessful backup you need to be in the folder that you want to backup
GPATH="$HOME/Google Drive/backups"	# Google Drive backup, works only if you have installed Google Drive

backup()	# For sucsessful backup you need to be in the folder that you want to backup
{
	if [ ! -d "${BPATH}/$*" ];
		then
			echo "Bakuping to ${BPATH}/$*"
			mkdir -p ${BPATH}/$*/
		else
			echo "Rewriting bakup to ${BPATH}/$*/"
			if [ ! -d "${BPATH}/_old" ];
				then
					mkdir -p ${BPATH}/_old
			fi
			if [ -d ${BPATH}/_old/$*/ ] && [ -d ${BPATH}/$*/ ];
				then
					rm -rf ${BPATH}/_old/$*/
					mkdir -p ${BPATH}/_old/$*/
					mv ${BPATH}/$*/* ${BPATH}/_old/$*/
				else
					mkdir -p ${BPATH}/_old/$*/
					mv ${BPATH}/$*/* ${BPATH}/_old/$*/
			fi
	fi
	cp -r $*/* ${BPATH}/$*/
}

delbackup()
{
	if [ -d "${BPATH}/$*" ];
		then
			echo "Deleting backup from ${BPATH}/$*"
			rm -rf ${BPATH}/$*
		else
			echo "Backup ${BPATH}/$* doesn't exist"
	fi
}

gdbackup()	# Google Drive backup, works only if you have installed Google Drive suddenly
{
	if [ -e "${GPATH}/$*.zip" ];
		then
			echo "Rewriting backup to ${GPATH}/$*.zip"
			rm -rf ${GPATH}/$*.zip
		else
			echo "Writing backup to ${GPATH}/$*.zip"
	fi
	zip -qr $*.zip $*
	mv $*.zip ${GPATH}/
}

gdelbackup()
{
	if [ -e "${GPATH}/$*.zip" ];
		then
			echo "Deleting google backup from ${GPATH}/$*.zip"
			rm -rf ${GPATH}/$*.zip
		else
			echo "Google backup ${GPATH}/$*.zip doesn't exist"
	fi
}

backup_restore()
{
	if [ -d "${BPATH}/$*" ];
		then
			echo "Getting backup from ${BPATH}/$*"
			cp -r ${BPATH}/$*/ .
		else
			if [ -e "${GPATH}/$*.zip" ];
			then
				echo "Getting Google backup from ${BPATH}/$*"
				cp ${GPATH}/$*.zip .
				unzip $*.zip
			else
				echo "Backup ${BPATH}/$* and ${GPATH}/$*.zip doesn't exist"
			fi
	fi
}

universal_backup()
{
	backup $1
	gdbackup $1
	if [ -d "$1" -a -d "$1/.git" -a ! -z "$2" ];
		then
			cd $1
			git add --all
			git commit -m "$2"
			git push
			cd ..
	fi
}

delete_universal_backup()
{
	if [ -e "${GPATH}/$*.zip" ];
		then
			echo "Deleting google backup from ${GPATH}/$*.zip"
			rm -rf ${GPATH}/$*.zip
		else
			echo "Google backup ${GPATH}/$*.zip doesn't exist"
	fi
	if [ -d "${BPATH}/$*" ];
		then
			echo "Deleting backup from ${BPATH}/$*"
			rm -rf ${BPATH}/$*
		else
			echo "Backup ${BPATH}/$* doesn't exist"
	fi
}

alias unibak=universal_backup
alias delunibak=delete_universal_backup
alias bak=backup
alias gbak=gdbackup
alias delbak=delbackup
alias gdelbak=gdelbackup
alias bakre=backup_restore
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH=$HOME/vbrazas/.oh-my-zsh
export ZSH=/nfs/2017/v/vbrazas/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTR$*KED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
# 	export EDITOR='vim'
# else
# 	export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# My email
export MAIL="vbrazas@student.unit.ua"

# Mongodb
# export PATH=/usr/local/mongodb/bin:$PATH

# Qt
#export PATH=$HOME/goinfre/Qt/5.6.3/clang_64/bin:$PATH

# Load Homebrew config script
source $HOME/.brewconfig.zsh


##### START OF BASH SCRIPTS #####
#### Colors definitions
GREEN='\e[0;32m'
RED='\e[0;31m'
YELLOW='\e[93m'
CYAN='\e[96m'
MAG='\e[95m'
BLUE='\e[1;34m'
RESET='\e[0m'

#### Backup scripts
#### You have to be in the folder, that contains the directories to backup
BPATH="$HOME/backups"	# For sucsessful backup you need to be in the folder that you want to backup
TAREXT="tar.xz"

abs_name()
{
	echo $(cd $(dirname $1); pwd)/$(basename $1)
}

get_name()
{
	if [ -f $1 ]; then
		pn=$(cd $(dirname $1); pwd)/$(basename $1)
		pn=${pn%%\/.}
		pn=${pn%%\/..}
		pn=${pn%%\/.git}
		pn=$(basename $pn)
	else
		pn=$(cd $1; pwd)
		pn=$(basename $pn)
	fi
	pn=${pn/#./}
	echo $pn
}

tar_backup()
{
	if [[ ! $1 ]] || ! $(ls $1 1> /dev/null); then
		echo "Usage: tbak <file|folder to backup> [path to put tarred file|folder]"
		return 1;
	fi

	if [[ ! -d ${BPATH} ]]; then
		mkdir ${BPATH}
	fi
	if [[ ! $2 ]]; then
		2=$BPATH
	elif [[ $(ls -ld $2 2> /dev/null | head -c 1) != 'd' ]]; then
		echo "Bad directory to backup name: $2"
		return 2;
	fi

	pn=$(get_name "$1")
	rm -f "$2/${pn}.$TAREXT"
	tar -cJf "$2/${pn}.$TAREXT" $(abs_name "$1")
}
alias tbak=tar_backup

backup()
{
	if [[ ! $1 ]] || ! $(ls $1 1> /dev/null); then
		echo "Usage: bak <file|folder to backup>"
		return 1;
	fi

	pn=$(get_name "$1")

	if [[ ! -e "${BPATH}/$1" ]]; then
		echo -n "Bakuping to ${BPATH}/$pn.$TAREXT"
	else
		echo -n "Rewriting bakup to ${BPATH}/$pn.$TAREXT"
	fi
	if [[ ! $2 && -d "$1/.git" ]]; then
		echo '.git'
		tar_backup $pn/.git ${BPATH}
	else
		echo '*'
		tar_backup $pn ${BPATH}
	fi
}
alias bak=backup

cdmkdir()
{
	mkdir -p $1
	cd $1
}
alias mkd=cdmkdir

universal_backup()
{
	if [[ ! $1 ]] || ! $(ls $1 1>/dev/null); then
		echo "Usage: unibak <file|folder to backup> [\"commit message\"]"
		return 1;
	fi

	if [ -d "$1" -a -d "$1/.git" -a $2 ]; then
		cd $1
		git add --all
		git commit -m $2
		if [[ $(git remote) ]]; then
			git push
		fi
		cd ..
	fi
	backup $1
}
alias unibak=universal_backup

#### Remove script
#### You have to be in the folder, that contains the directories to remove ####
BIP="$HOME/.Trash/"
remove()
{
	echo "Removing to ${BIP}"
	for i in $*; do
		rm -rf ${BIP}$i
		mv $i ${BIP}
	done
}
alias re=remove

mamp()
{
	MAMP=$HOME/Library/Containers/MAMP
	CONFF="$MAMP/apache2/conf/bitnami/bitnami.conf"
	IMAIN="Include \"$HOME/http/main.conf\""
	IMATCHA="Include \"$HOME/http/matcha.conf\""

	put_usage()
	{
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
		open $HOME/Downloads/bitnami-mampstack-7.1.24-0-osx-x86_64-installer.dmg
	elif [[ $1 == "-h" || $1 == "--help" || $2 || "$*" == "" ]]; then
		put_usage
	else
		put_usage
	fi
}
# export MAMP="$HOME/Library/Containers/MAMP"
# alias remamp='mamp -r; mamp -i; sleep 10; while [[ $(diskutil list | grep MAMP) ]]; do sleep 5; done; mamp -l'
# alias mysql='~/Library/Containers/MAMP/mysql/bin/mysql'

change_extension()
{
	if [[ $1 == "-h" || $1 == "--help" || $1 == "?" ]]; then
		echo "chext –– changes extesions for all files in current folder"
		echo "Usage: chext OLD_FILE_EXTENSION NEW_FILE_EXTENSION"
		return;
	fi

	for f in *.$1; do
		mv $f `basename $f .$1`.$2;
	done;
}
alias chext=change_extension

clean_library_mac()
{
	TELEGA="$HOME/Library/Group\\ Containers/*.Telegram/account-*/postbox/media"

	rm -rf $HOME/Library/*42_cache*
	rm -rf $HOME/.*42_cache*
	rm -rf $HOME/.*zcompdump*
	rm -rf $HOME/.Trash
	mkdir -p $HOME/.Trash
	echo "${YELLOW}To clean up telegram cache execute next command:\n$: rm -rf ${TELEGA}${RESET}"
}
alias clm=clean_library_mac

vscode_sync()
{
	GIST="https://gist.githubusercontent.com/Millon15/83e066d54e1393b35443f23f3fc41cda/raw/"
	VSCODE="$HOME/Library/Application Support/Code/User/"

	for i in keybindings.json settings.json; do
		curl ${GIST}/$i | sed -e "s/vbrazas/$(whoami)/g" > ${VSCODE}/$i
	done
}
alias vscs=vscode_sync

zshrc_sync()
{
	TEXT="https://raw.githubusercontent.com/Millon15/bash_scripts/master/.zshrc"

	tar_backup $HOME/.zshrc
	curl $TEXT \
	| sed -e "s:export ZSH=/nfs/2017/v/vbrazas/.oh-my-zsh:export ZSH=\$HOME/$(whoami)/.oh-my-zsh:" \
	-e "s:export MAIL=\"vbrazas@student.unit.ua\":export MAIL=\"$(whoami)@student.unit.ua\":g" \
	> $HOME/.zshrc
}
alias zshs=zshrc_sync

zshrc_backup()
{
	BSDIR="$HOME/projects/bash_scripts/"

	cp $HOME/.zshrc $BSDIR
	if [[ "$1" ]]; then
		universal_backup $BSDIR "Another backup"
	fi
}
alias zbak=zshrc_backup
alias cld='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc -e REMOVE_VOLUMES=1 spotify/docker-gc'

##### END OF BASH SCRIPTS #####


# My aliases
alias l='ls -G'
alias la='ls -AG'
alias lr='ls -RG'
alias ll='ls -lAG'
alias lll='ls -lRG'

alias cd..='cd ..'
alias c=cd
alias c..='cd ..'
alias cc=cd
alias ..='cd ..'
alias ...='cd ../..'

alias gi="git init"
alias ga='git add'
alias gaa='git add --all'
alias gs='git status'
alias gc='git commit -m "'
alias gcm='git commit -m "'
alias gch='git checkout'
alias gf='git fetch'
alias gcl='git clone --recurse-submodules'
alias gls='git ls-files'
alias gp='git push'
alias grm='git rm'
alias gsm='git submodule'
alias gpu='git push -u origin master'
alias gm='git merge'
alias gst='git stash'
alias grs='git reset'
alias grsh='git reset --hard'
alias grb='git rebase'
alias gr='git remote'
alias gt='git tag'
alias grv='git remote -v'
alias gra='git remote add'
alias grao='git remote add origin'
alias gl="git log --oneline --decorate --all --graph"
alias gll='git pull'

alias n=npm
alias ni='npm install'
alias ns='npm start'

alias nr='norminette'
alias mr='norminette -R CheckForbiddenSourceHeader'
alias o=open
alias v=vim
alias emacs=vim

alias ca=cat
alias b=bat
alias vzs='vim $HOME/.zshrc'
alias cae='cat -e'
alias cp='cp -r'
alias rf='rm -rf'
alias p=pwd
alias t=touch
alias cl=clear
alias rs=reset
alias es='echo $?'
alias mk='mkdir -p'
alias m=make
alias src='source'
alias szs='source ~/.zshrc'
alias ec=echo
alias 42fc='bash ~/42FileChecker/42FileChecker.sh'
alias bc='bc -qilw'

alias cb="/usr/bin/osascript -e 'tell application \"System Events\" to tell process \"Terminal\" to keystroke \"k\" using command down'"
alias s='open -a "Sublime Text"'
alias vsc='open -a "Visual Studio Code"'
alias avs="df -h | grep /dev/disk2 | awk '{print \$4}'"

clear

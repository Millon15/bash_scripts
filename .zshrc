# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
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
DISABLE_AUTO_UPDATE="true"

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

# Load Homebrew config script
source $HOME/.brewconfig.zsh


##### START OF BASH SCRIPTS #####
#### Backup scripts
#### You have to be in the folder, that contains the directories to backup
BPATH="$HOME/backups"				# For sucsessful backup you need to be in the folder that you want to backup
GPATH="$HOME/Google Drive/backups"	# Google Drive backup, works only if you have installed Google Drive

gdbackup()							# Google Drive backup, works only if you have installed Google Drive suddenly
{
	if [[ ! $1 ]]; then
		exit 1;
	fi

	EXT="tar.gz"

	mkdir -p ${GPATH}
	if [[ -e "${GPATH}/$1.${EXT}" ]]; then
		echo "Rewriting backup to ${GPATH}/$1.${EXT}"
		rm -f "${GPATH}/$1.${EXT}"
	else
		echo "Writing backup to ${GPATH}/$1.${EXT}"
	fi
	tar -czf "$1.${EXT}" $1
	mv "$1.${EXT}" ${GPATH}
}
alias gbak=gdbackup

backup()							# For sucsessful backup you need to be in the folder that you want to backup
{
	if [[ ! $1 ]]; then
		exit 1;
	fi

	OLD_D="${BPATH}/_old/"

	if [[ ! -d "${BPATH}/$1" ]]; then
		echo "Bakuping to ${BPATH}/$1"
	else
		echo "Rewriting bakup to ${BPATH}/$1/"
		if [ ! -d "$OLD_D" ]; then
			mkdir -p $OLD_D
		fi
		rm -rf $OLD_D/$1
		mv ${BPATH}/$1 $OLD_D
	fi
	if [[ ! -d "${BPATH}/$1/.git" ]]; then
		cp -r $1 ${BPATH}
	else
		mkdir -p ${BPATH}/$1
		cp -r $1/.git ${BPATH}/$1/
	fi
}
alias bak=backup

universal_backup()
{
	if [ -z "$3" ]; then
		backup $1
		gdbackup $1
	fi
	if [ -d "$1" -a -d "$1/.git" -a ! -z "$2" ]; then
		cd $1
		is_first_commit=$(git log 2> /dev/null | cat);
		git add --all
		git commit -m $2
		if [[ $4 == "" ]]; then
			if [[ $is_first_commit == "" ]]; then
				git push --set-upstream origin master
			else
				git push
			fi
		fi
		cd ..
	fi
}
alias unibak=universal_backup

#### Remove script
#### You have to be in the folder, that contains the directories to remove ####
BIP="$HOME/.Trash/"
remove()
{
	echo "Removing to ${BIP}"
	for i in $*;
	do
		rm -rf ${BIP}$i
		mv $i ${BIP}
	done
}
alias re=remove

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
	rm -rf $HOME/Library/*42_cache*
	rm -rf $HOME/.*42_cache*
	rm -rf $HOME/.*zcompdump*
	rm -rf $HOME/.Trash
	mkdir -p $HOME/.Trash
	rm -rf $HOME/Library/Group\ Containers/6N38VWS5BX.ru.keepcoder.Telegram/account-7583096117702376182/postbox/media
	mkdir -p $HOME/Library/Group\ Containers/6N38VWS5BX.ru.keepcoder.Telegram/account-7583096117702376182/postbox/media
}
alias clm=clean_library_mac

alias zbak='cp $HOME/.zshrc $HOME/projects/bash_scripts/'
alias cld='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc -e REMOVE_VOLUMES=1 spotify/docker-gc'

##### END OF BASH SCRIPTS #####


# My aliases
alias l='ls -G'
alias .=ls
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
alias gcl='git clone'
alias gls='git ls-files'
alias gp='git push'
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias grao='git remote add origin'
alias gl="git log --oneline --decorate --all --graph"
alias gll='git pull'

alias nr='norminette'
alias mr='norminette -R CheckForbiddenSourceHeader'
alias o=open
alias v=vim
alias e=emacs

alias ca=cat
alias cae='cat -e'
alias cp='cp -r'
alias p=pwd
alias cl=clear
alias rs=reset
alias es='echo $?'
alias mk='mkdir -p'
alias m=make
alias src='source'
alias szs='source ~/.zshrc'
alias ec=echo
alias 42fc='bash ~/42FileChecker/42FileChecker.sh'
alias bcc='bc -qilw'

alias cb="/usr/bin/osascript -e 'tell application \"System Events\" to tell process \"Terminal\" to keystroke \"k\" using command down'"
alias s='open -a "Sublime Text"'
alias vsc='open -a "Visual Studio Code"'

# alias lss='~/projects/archive/git_archive/ft_ls/ft_ls'
alias mamp='~/projects/bash_scripts/mamp.zsh'
export MAMP="$HOME/Library/Containers/MAMP"
alias mysql='~/Library/Containers/MAMP/mysql/bin/mysql'

clear
# screenfetch -E
#!/bin/bash

#gil()
# {
#	/bin/bash $HOME/projects/bash_scripts/this.sh "$@"
# }
#alias git='gil'
#[url ""] insteadOf = 

aim=""
ai=0
clon=0
tmp=0

for var in "$@"
do
	if [[ ${var} = "clone" ]]; then
		clon=1
		continue
	fi
	if [[ ${clon} = 1 && ${var} = ${aim} ]]; then
		ai=1
		break
	fi
done

if [[ ${clon} = 1 && ${ai} = 1 ]]; then
	if git "$@"; then
		echo -e "[user]\n\temail = appleitunesstore11@gmail.com\n\tname = vbrazas" > ~/.gitconfig
		tdir=$(mktemp -d /tmp/foo.XXXXXXXXX)
		git clone ${aim} ${tdir}/tmp &> /dev/null
	fi
else
	git "$@"
fi

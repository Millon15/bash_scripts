#!/bin/zsh
ascii=($(echo " \!\"\#\$\%\&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\[\\\]^_\`abcdefghijklmnopqrstuvwxyz{|}~" | grep -o .))
arlen=${#ascii[@]}
i=$1

while [[ $1 ]]; do
	echo ${ascii[$RANDOM%$arlen]}
	let i--;
done

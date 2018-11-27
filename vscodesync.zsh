#!/bin/zsh

GIST=https://gist.githubusercontent.com/Millon15/83e066d54e1393b35443f23f3fc41cda/raw/4cfa60c50561e8f4baaf9e3c60205c5ea35c7866/
VSCODE=$HOME/Library/Application\ Support/Code/User/

for i in keybindings.json settings.json; do
	curl ${GIST}/$i > ${VSCODE}/$i
done

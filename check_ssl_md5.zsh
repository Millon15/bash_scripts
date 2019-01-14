#!/bin/zsh

FILENAME=.tmp_$RANDOM

echo > $FILENAME
for (( i = 0; i < $1; i++ )); do
	arr+=($(($RANDOM%256)));
done
for (( i = 0; i < $1; i++ )); do
	echo -n "\x$(printf %x ${arr[$i]})" >> $FILENAME
done

# diff <(md5 .tmp_9418) <(md5 .tmp_20613)

#!/bin/bash
if [[ $(./du -h -d 0 ~ | grep \/Users\/vbrazas | cut -c 1) > 3 && $(ls -1 ~/Library/ | awk '/.*42_cache_.*/') ]];
	then
		rm -rf ~/Library/*42_cache_*
fi

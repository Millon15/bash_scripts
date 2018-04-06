#!/bin/bash

cd ~/Library/
du -hs * | grep "Application Support.42" | cut -d $'\t' -f2 | sed 's/^Application/Application\\/g' | xargs rm -rf

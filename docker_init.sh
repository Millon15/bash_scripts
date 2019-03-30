#!/bin/bash

# CONFIGURE script for setting up docker under UNIT school infrastructure

# To INSTALL docker follow instructions below:
# curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
# Then relaunch terminal... and fire next command:
# brew install docker docker-machine docker-compose

# Coz in UNIT we have only 5Gb of personal user storage it seems expedient
# to link ~/.docker file to some big tmp storage either ~/goinfre or /tmp
TMP_DIR="$HOME/goinfre/"

[[ -L $HOME/.docker ]] && rm $HOME/.docker
[[ -d $HOME/.docker ]] && mv $HOME/.docker ${TMP_DIR}${USER}_docker/

docker-machine create   --virtualbox-disk-size "15360" \
                        --virtualbox-boot2docker-url https://github.com/boot2docker/boot2docker/releases/download/v18.09.1/boot2docker.iso \
                        -d virtualbox   default

docker-machine stop default

mkdir -p ${TMP_DIR}${USER}_docker/
cp -R $HOME/.docker/* ${TMP_DIR}${USER}_docker/
rm -rf $HOME/.docker
ln -s ${TMP_DIR}${USER}_docker/ $HOME/.docker

docker-machine start default

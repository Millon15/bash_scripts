#!/bin/bash

TMP_DIR="$HOME/goinfre/"

docker-machine create -d virtualbox default
docker-machine stop default
cp -R ~/.docker "${TMP_DIR}${USER}_docker/"
rm -rf ~/.docker
ln -s "${TMP_DIR}${USER}_docker/" .docker
docker-machine start default

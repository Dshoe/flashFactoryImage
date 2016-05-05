#!/bin/bash

FILENAME="$1"
ROOT_FOLDER="factory_image/"
IMAGE_FOLDER="image/"

if [ ! -d $ROOT_FOLDER ]; then
	mkdir $ROOT_FOLDER
fi
tar zxvf $FILENAME -C $ROOT_FOLDER
cd $ROOT_FOLDER
cd */
unzip *.zip -d $IMAGE_FOLDER
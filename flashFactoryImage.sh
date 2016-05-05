#!/bin/bash

FILENAME="$1"
FOLDER="factory_image/"
#$DIRECTORY="factory_image/"
if [ ! -d $FOLDER ]; then
	mkdir $FOLDER
fi
tar zxvf $FILENAME -C $FOLDER
cd $FOLDER
cd */
#mkdir image/
unzip *.zip -d image
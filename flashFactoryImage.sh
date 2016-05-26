#!/bin/bash

FILENAME="$1"
ROOT_FOLDER="factory_image/"
IMAGE_FOLDER="image/"

bflag='false'
rflag='false'
cflag='false'

while getopts 'brc' flag; do
	case "${flag}" in
		b) bflag='true' ;;
		r) rflag='true' ;;
		c) cflag='true' ;;
		*) error "Unexpected option ${flag}" ;;
	esac
done

if [ ! -d $ROOT_FOLDER ]; then
	mkdir $ROOT_FOLDER
fi
tar zxvf $FILENAME -C $ROOT_FOLDER
cd $ROOT_FOLDER
cd */
unzip *.zip -d $IMAGE_FOLDER

./flash-base.sh
cd $IMAGE_FOLDER
fastboot flash boot boot.img
fastboot reboot-bootloader
sleep 5
fastboot flash system system.img
fastboot reboot-bootloader
sleep 5
fastboot flash vendor vendor.img
fastboot reboot-bootloader
sleep 5

if [ $bflag == 'true' ]
	then
		fastboot flash boot boot.img
		fastboot reboot-bootloader
		sleep 5
fi

if [ $rflag == 'true' ]
	then
		fastboot flash recovery recovery.img
		fastboot reboot-bootloader
		sleep 5
fi

fastboot reboot

if [ $cflag == 'false' ]
	then
		cd ../../../
		rm -rf $ROOT_FOLDER
fi

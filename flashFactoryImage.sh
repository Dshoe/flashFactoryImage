#!/bin/bash

# Declare variables
FILENAME=""
ROOT_FOLDER="factory_image/"
IMAGE_FOLDER="image/"

BOOTIMGFLAG="false"
RECOVERIMGFLAG="false"
CLEANFLAG="true"

# Detect possible flags
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -f|--file)
    FILENAME="$2"
    shift # past argument
    ;;
    -b|--boot)
    BOOTIMGFLAG="true"
    shift # past argument
    ;;
    -r|--recovery)
    RECOVERIMGFLAG="true"
    shift # past argument
    ;;
    -a|--all)
  	BOOTIMGFLAG="true"
  	RECOVERIMGFLAG="true"
  	;;
    -dc|--dont-clean)
    CLEANFLAG="false"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

# Check if file path has been specified
if [ ! $FILENAME == "" ]
	then

	# Create the root folder if it does not exist
	if [ ! -d $ROOT_FOLDER ]; then
		mkdir $ROOT_FOLDER
	fi

	# Extract factory image
	unzip $FILENAME -d $ROOT_FOLDER
	cd $ROOT_FOLDER
	cd */
	unzip *.zip -d $IMAGE_FOLDER

	# Flash components
	./flash-base.sh
	cd $IMAGE_FOLDER
	fastboot flash system system.img
	fastboot reboot-bootloader
	sleep 5
	fastboot flash vendor vendor.img
	fastboot reboot-bootloader
	sleep 5

	if [ $BOOTIMGFLAG == 'true' ]
		then
			fastboot flash boot boot.img
			fastboot reboot-bootloader
			sleep 5
	fi

	if [ $RECOVERIMGFLAG == 'true' ]
		then
			fastboot flash recovery recovery.img
			fastboot reboot-bootloader
			sleep 5
	fi

	fastboot reboot

	# Remove the root folder
	if [ $CLEANFLAG == 'true' ]
		then
			cd ../../../
			rm -rf $ROOT_FOLDER
	fi

else
	echo "No factory image file specified."
fi

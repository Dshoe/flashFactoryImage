# flashFactoryImage
Bash script to flash factory images to Nexus devices without wiping user data, or overwriting a custom recovery and kernel.

Flags
* -f|--file:        Flash designated file (this is followed by the file's path)
* -r|--recovery:    Flash recovery.img as well
* -dc|--dont-clean: Don't delete the factory_image folder after flashing

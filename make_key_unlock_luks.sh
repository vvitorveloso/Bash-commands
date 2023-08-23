#!/bin/bash

#######################################################
SIZE=8192

END_DISK=$(($(sudo blockdev --getsz /dev/$1 ) - $(($SIZE / 512 ))))
BY_ID=$( ls -l /dev/disk/by-id/ | grep $1 | grep -v part| cut -d" " -f 11 | cut -d ":" -f1)
BY_ID_END=$( ls -l /dev/disk/by-id/ | grep $1 | grep -v part| cut -d" " -f 11 | cut -d ":" -f2 | cut -d" " -f1)

######################################################

echo '##################################################################################'
echo '####### This script write an random key in the end of a specified device #########'
echo '############ YOU CAN´T FORGET TO SAVE SPACE IN THE END OF THE DEV  ###############'
echo '##################################################################################'
echo ""
echo ""

udevadm info -q symlink --path=/sys/block/$1 
udevadm info -q symlink --path=/sys/block/sde


if [ $# -eq 0 ]
	then
		echo "refusing to run without parameter"
		echo "use dev as parameter Ex: ./script.sh sdX"
		exit 1
fi

echo "generating random key:"

dd if=/dev/random of=/tmp/temp_key bs=1 count=$SIZE 


##
echo ""
echo ""
echo "writing key to dev:"
echo "sudo dd if=/tmp/temp_key of=/dev/$1 bs=1 count=$SIZE seek=$END_DISK"
sudo dd if=/tmp/temp_key of=/dev/$1 bs=1 count=$SIZE seek=$END_DISK
echo "end of writing"

echo ""
echo ""
echo "checking key..."
sudo dd if=/dev/$1 of=/tmp/check skip=$END_DISK bs=1 count=$SIZE

if [ $(md5sum /tmp/check| cut -d" " -f1) == $(md5sum /tmp/temp_key| cut -d" " -f1) ]
	then
		echo ""
		echo "everthing is fine"
	else
		echo "checking failed, exiting..."
		echo ""
		echo "dev key:"
		md5sum /tmp/check | cut -d" " -f1
		echo "temp key"
		md5sum /tmp/temp_key | cut -d" " -f1
		exit 1
		
fi
##

#echo $BY_ID

echo ""

echo '#############################################################'
echo '####### Dont forget to add needed modules to initrd #########'
echo '### In my case "mmc_block usb_storage uas ums_realtek"  #####'
echo '#############################################################'

echo ""
echo '#######replace the device and run this#########'

echo 'sudo cryptsetup luksAddKey "LUKS_DEVICE_HERE" /tmp/temp_key'

echo ""
echo '#######add this to boot args#########'

echo cryptkey=/dev/disk/by-id/$BY_ID'\':$BY_ID_END:$END_DISK:$SIZE 

echo ""
echo '####### OR|AND add this to /etc/crypttab#########'
echo '############ In my case i use both ##############'
echo '## i have the home partition and root encrypted##'
echo '#################################################'


echo ' <name>       <device>                                     <password>              <options>'
echo your_partition_name LUKS_DEVICE_HERE /dev/disk/by-id/$BY_ID:$BY_ID_END luks,keyfile-offset=$END_DISK,keyfile-size=$SIZE,tries=3


echo ""
echo "test with:"
echo sudo cryptsetup luksOpen /dev/LUKS_DEVICE_HERE --key-file=/dev/disk/by-id/$BY_ID:$BY_ID_END --keyfile-size=$SIZE --keyfile-offset=$END_DISK --test-passphrase
echo ""
echo "run again with other device for a bkp:"
echo sudo dd if=/tmp/temp_key of=/dev/$1 bs=1 count=$SIZE seek=$END_DISK

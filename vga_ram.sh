#!/bin/bash

#Clean
sudo swapoff -a
sudo killall vramfs
sudo umount /tmp/vram
sudo rm -rf /tmp/vram
sudo losetup --detach-all

sudo mkdir /tmp/vram 
sudo vramfs /tmp/vram 99GB -f &
sleep 1
#sudo dd if=/dev/zero of=/tmp/vram/swapfile bs=1M count=790 # Substitute 200 with your target swapspace size in MB
#sudo chmod 600 /tmp/vram/swapfile
#sudo chown root:root /tmp/vram/swapfile
#sudo mkswap /tmp/vram/swapfile
#sudo swapon /tmp/vram/swapfile
sleep 1
ram=$(sudo df -B1 /tmp/vram | grep vramfs | awk '{print $2}' )

#cd /tmp/vram
LOOPDEV=$(losetup -f)
echo $ram
sudo truncate -s $ram /tmp/vram/swapfile # replace 4G with target swapspace size, has to be smaller than the allocated vramfs
sudo losetup $LOOPDEV /tmp/vram/swapfile
sleep 1
mkswap $LOOPDEV
sleep 1
sudo swapon $LOOPDEV

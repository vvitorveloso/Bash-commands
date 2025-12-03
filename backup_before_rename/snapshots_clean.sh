#!/bin/bash

sudo btrfs subvolume delete /mnt/home/.snapshots/*/snapshot*
sudo btrfs subvolume delete /home/.snapshots/*/snapshot*
sudo btrfs subvolume delete /.snapshots/*/snapshot*

for i in $(sudo ls /home/.snapshots/); do  sudo rm -rf /home/.snapshots/$i;done
for i in $(sudo ls /mnt/home/.snapshots/); do  sudo rm -rf /mnt/home/.snapshots/$i;done
for i in $(sudo ls /.snapshots/); do  sudo rm -rf /.snapshots/$i;done

sudo ls /home/.snapshots/
sudo ls /mnt/home/.snapshots/
sudo ls /.snapshots/

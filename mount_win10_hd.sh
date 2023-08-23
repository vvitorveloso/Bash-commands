modprobe nbd
qemu-nbd --connect=/dev/nbd0 /home/ochi/VMs/Win10/Win10.qcow2
mount /dev/nbd0p1 /mnt/Win10HD

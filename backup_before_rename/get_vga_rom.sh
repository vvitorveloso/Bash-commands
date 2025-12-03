cd /sys/bus/pci/devices/0000:02:00.0/                   
echo 1 > rom 
cat rom > /boot/vbios.rom
echo 0 > rom

sleep 1

echo 1 > /sys/bus/pci/devices/0000:02:00.0/enable
echo 1 > /sys/bus/pci/devices/0000:02:00.0/rom
cat /sys/bus/pci/devices/0000:02:00.0/rom > /boot/gpu.rom
echo 0 > /sys/bus/pci/devices/0000:02:00.0/rom
echo 0 > /sys/bus/pci/devices/0000:02:00.0/enable

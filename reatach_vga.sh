echo "1" > /sys/bus/pci/devices/0000:02:00.1/remove 
echo "1" > /sys/bus/pci/devices/0000:02:00.0/remove 
sleep 2 
echo "1" > /sys/bus/pci/rescan

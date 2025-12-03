echo '0000:02:00.1' | tee /sys/bus/pci/devices/0000:02:00.1/driver/unbind
echo '0000:02:00.0' | tee /sys/bus/pci/devices/0000:02:00.1/driver/unbind


modprobe vfio
modprobe vfio_pci

echo 10de 0de0 | tee /sys/bus/pci/drivers/vfio-pci/new_id
echo 10de 0bea | tee /sys/bus/pci/drivers/vfio-pci/new_id

sudo rmmod vfio vfio_iommu_type1 vfio_virqfd vfio_pci

#pcidev="0000:08:00.0"
id=" ids=10de:1292"
modules="vfio vfio_iommu_type1 vfio_virqfd vfio_pci"

#sudo modprobe vfio vfio_iommu_type1 vfio_virqfd vfio_pci
#sudo rmmod nvidia
#echo "10de 1292" | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id


#echo $dev |sudo tee /sys/bus/pci/devices/$pcidev/driver/unbind
#echo $ven $dev |sudo tee /sys/bus/pci/drivers/vfio-pci/new_id

#sudo modprobe vfio-pci ids=10de:1292
#echo 0000:08:00.0| sudo tee /sys/bus/pci/drivers_probe



#sudo tee /proc/acpi/bbswitch <<< ON
#sudo modprobe vfio vfio_iommu_type1 vfio_virqfd vfio_pci ids=10de:1292

for i in $modules;do
if [ $i == "vfio_pci" ];then
sudo modprobe $i $id
else
sudo modprobe $i
fi
done

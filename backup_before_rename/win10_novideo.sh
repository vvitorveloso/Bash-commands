qemu-system-x86_64 \
-enable-kvm \
-m 4000 \
-smp 2 \
-cpu host \
-vga none -nographic \
-name guest=RDPWindows,debug-threads=on \
-drive file=/usr/share/ovmf/x64/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on  \
-drive file=/home/ochi/VMs/Win10/UEFI/OVMF_VARS.fd,if=pflash,format=raw,unit=1  \
-machine pc-q35-5.1,accel=kvm \
-uuid 28cb4d35-f230-43b0-8414-23eef86948c6 \
-boot menu=on,strict=on \
-device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b \
-device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
-netdev user,id=mynet.0,net=10.0.10.0/24,hostfwd=tcp::3389-:3389 \
-device virtio-net,netdev=mynet.0  \
-sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny -msg timestamp=on \
-drive file=/home/ochi/VMs/Win10/Win10.qcow2,if=virtio 


#-device virtio-balloon-pci,id=balloon0 \
#-device virtio-vga,virgl=on \
#-display gtk,gl=on \

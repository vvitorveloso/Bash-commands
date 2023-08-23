#!/bin/bash

#export QEMU_AUDIO_DRV=pa
#QEMU_AUDIO_DRV=pa


/usr/bin/qemu-system-x86_64  \
    -nographic \
    -enable-kvm \
    -m 3108  \
    -machine q35,accel=kvm \
    -cpu max  \
    -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x2  \
    -device pcie-pci-bridge,id=pci.2,bus=pci.1,addr=0x0  \
    -device pcie-root-port,port=0x11,chassis=3,id=pci.3,bus=pcie.0,addr=0x2.0x1  \
    -device pcie-root-port,port=0x12,chassis=4,id=pci.4,bus=pcie.0,addr=0x2.0x2  \
    -device pcie-root-port,port=0x13,chassis=5,id=pci.5,bus=pcie.0,addr=0x2.0x3  \
    -device pcie-root-port,port=0x14,chassis=6,id=pci.6,bus=pcie.0,addr=0x2.0x4  \
    -device ich9-usb-ehci1,id=usb,bus=pcie.0,addr=0x1d.0x7  \
    -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pcie.0,multifunction=on,addr=0x1d  \
    -device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pcie.0,addr=0x1d.0x1  \
    -device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pcie.0,addr=0x1d.0x2  \
    -drive file=/usr/share/ovmf/x64/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on  \
    -drive file=/usr/share/ovmf/x64/OVMF_VARS.fd,if=pflash,format=raw,unit=1  \
    -drive file=/dev/disk/by-id/ata-WDC_WD5000AAKS-00V1A0_WD-WMAWF1289770-part1,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native  \
    -device virtio-blk-pci,scsi=off,bus=pci.6,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=2,write-cache=on  \
    -drive file=/usr/share/spice-guest-tools/spice-guest-tools.iso,format=raw,if=none,id=drive-sata0-0-0,readonly=on  \
    -device ide-cd,bus=ide.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1  \
    -drive file=/usr/share/virtio/virtio-win.iso,format=raw,if=none,id=drive-sata0-0-1,readonly=on  \
    -device ide-cd,bus=ide.1,drive=drive-sata0-0-1,id=sata0-0-1   \
    -device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b  \
    -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0  \
    -device virtio-balloon-pci,id=balloon0,bus=pci.5,addr=0x0  \
    -netdev user,id=mynet.0,net=10.0.10.0/24,hostfwd=tcp::3389-:3389  \
    -device virtio-net-pci,netdev=mynet.0



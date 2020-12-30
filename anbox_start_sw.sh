#!/bin/bash

sudo modprobe ashmem_linux
sudo modprobe binder_linux


sudo ANBOX_FORCE_SOFTWARE_RENDERING=true /usr/bin/anbox container-manager --daemon --privileged --data-path=/var/lib/anbox --use-rootfs-overlay  &

sleep 1

#sudo bash /usr/lib/anbox/anbox-bridge.sh start
anbox-bridge

sleep 2
ANBOX_FORCE_SOFTWARE_RENDERING=true anbox launch --package=org.anbox.appmgr --component=org.anbox.appmgr.AppViewActivity &

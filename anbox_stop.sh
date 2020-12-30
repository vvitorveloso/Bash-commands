#!/bin/bash


sudo bash /usr/lib/anbox/anbox-bridge.sh stop
bash /usr/lib/anbox/anbox-bridge.sh stop
sudo ip link del anbox0

sudo rmmod ashmem_linux
sudo rmmod binder_linux

sudo systemctl daemon-reload
systemctl --user daemon-reload

sudo systemctl stop anbox-container-manager.service 
                                                                                           
systemctl --user stop anbox-session-manager.service

sudo killall anbox

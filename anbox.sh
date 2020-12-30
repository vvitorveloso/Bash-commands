#!/bin/bash

sudo systemctl stop firewalld.service

sudo ip link del anbox0

sudo bash /usr/lib/anbox/anbox-bridge.sh stop
bash /usr/lib/anbox/anbox-bridge.sh stop

sudo rmmod ashmem_linux
sudo rmmod binder_linux

sudo modprobe ashmem_linux
sudo modprobe binder_linux

sudo systemctl daemon-reload
systemctl --user daemon-reload

sudo systemctl stop anbox-container-manager.service 
                                                                                           
#systemctl --user stop anbox-session-manager.service

sleep 3
sudo systemctl start anbox-container-manager.service                                          
sleep 4

#systemctl --user start anbox-session-manager.service 

#sudo bash /usr/lib/anbox/anbox-bridge.sh start
anbox-bridge

sleep 4
anbox launch --package=org.anbox.appmgr --component=org.anbox.appmgr.AppViewActivity

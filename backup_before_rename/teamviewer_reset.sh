#!/bin/bash
sudo systemctl stop teamviewerd.service
rm -rf .config/teamviewer
sudo rm -rf /etc/teamviewer
sudo rm  /opt/teamviewer/config

sudo systemctl stop NetworkManager 
sudo macchanger -r wlp6s0
sudo macchanger -r enp7s0
sudo systemctl start NetworkManager 

sudo systemctl start teamviewerd.service

#/etc/NetworkManager/conf.d/macchange.conf
####################
#[device]
#wifi.scan-rand-mac-address=no
#[connection]
#ethernet.cloned-mac-address=preserve
#wifi.cloned-mac-address=preserve
#####################

teamviewer

sudo systemctl stop NetworkManager
sudo macchanger -p wlp6s0
sudo macchanger -p enp7s0
sudo systemctl start NetworkManager

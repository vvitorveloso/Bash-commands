#!/bin/bash

sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bkp
#undo 
#sudo cp /etc/pulse/default.pa.bkp /etc/pulse/default.pa

echo " " | sudo tee -a /etc/pulse/default.pa
echo '############################### FIX MIC FOR LENOVO 320' | sudo tee -a /etc/pulse/default.pa
echo load-module module-remap-source source_name=record_mono master=$(pacmd list-sources | grep 'name:.*input'| cut -d"<" -f2 |cut -d">" -f1) master_channel_map=front-left channel_map=mono | sudo tee -a /etc/pulse/default.pa
echo set-default-source record_mono | sudo tee -a /etc/pulse/default.pa

pulseaudio -k
pulseaudio --start

#!/bin/bash

sudo cat /sys/kernel/debug/dri/0/pstate
if [[ "$1" == "min" ]];then
 echo 07 | sudo tee /sys/kernel/debug/dri/0/pstate
echo min
fi

if [[ "$1" == "med" ]];then
 echo 0a | sudo tee /sys/kernel/debug/dri/0/pstate
echo med
fi

if [[ "$1" == "max" ]];then
 echo 0f | sudo tee /sys/kernel/debug/dri/0/pstate
echo max
fi

if [[ "$1" == "ac" ]];then
 echo AC | sudo tee /sys/kernel/debug/dri/0/pstate
echo AC
fi


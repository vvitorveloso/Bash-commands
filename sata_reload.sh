#!/bin/bash

echo 0 0 0 | sudo tee /sys/class/scsi_host/host*/scan
sudo partprobe

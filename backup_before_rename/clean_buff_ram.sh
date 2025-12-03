#!/bin/bash
sync 
echo 1 | sudo tee -a /proc/sys/vm/drop_caches

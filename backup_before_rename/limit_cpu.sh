#!/bin/bash
echo 2000000 | sudo tee /sys/bus/cpu/devices/cpu*/cpufreq/scaling_max_freq

#!/bin/bash

sudo grep -H '' /sys/module/$1*/parameters/* | grep "$2" 


#!/bin/bash
for i in $(ps aux | grep chromium| cut -d" " -f 7);do sudo cpulimit -p $i --limit 30 & ;done

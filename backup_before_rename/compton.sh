#!/bin/bash
if [ "$(echo $XDG_CURRENT_DESKTOP)" == "lxqt" ]
then compton --backend glx --xrender-sync-fence &
fi

if [ "$(echo $XDG_CURRENT_DESKTOP)" == "LXDE" ]
then compton --backend glx --xrender-sync-fence &
fi

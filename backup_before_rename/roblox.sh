#!/bin/bash
echo 'grapejuice player ' '"'$*'"' > /tmp/launch.sh
chmod +x /tmp/launch.sh
xinit /tmp/launch.sh -- :5 -nolisten tcp vt5 -config /home/ochi/xorg-game.conf

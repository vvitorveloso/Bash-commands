#!/bin/bash
PASS=$(secret-tool lookup server RDP)
VMIP=$(sudo virsh net-dhcp-leases default | grep -o 192.168.......... | cut -d "/" -f1| head -n1)
#xfreerdp  +drives +window-drag +aero +home-drive  +clipboard /sec:tls /d:AzureAD  /gfx-h264 /bpp:32 /rfx /u:vitorrfveloso@outlook.com.br /p:$PASS /v:127.0.0.1:3389
#xfreerdp +window-drag +aero +home-drive  +clipboard /sec:tls /d:AzureAD   /sound:sys:pulse  /gfx:rfx /bpp:32 /rfx /u:vitorrfveloso@outlook.com.br /p:$PASS /w:1300 /h:708 /v:127.0.0.1:3389 +fonts +gfx-progressive -compression /dynamic-resolution   #/gdi:hw +multitouch
#wlfreerdp  +drives  -clipboard /gfx-h264 /bpp:32 /rfx /u:ochi /p:123 /w:1366 /h:768 /v:127.0.0.1:3389  /drive:home,/home/XXX
#/sound:sys:pulse /u:XXX /p:YYY  /v:127.0.0.1:3389  


#wlfreerdp  +drives /drive:home,/home/ochi  +clipboard  /smart-sizing  /d:AzureAD  /sec:tls  /sound:sys:pulse   /u:vitorrfveloso@outlook.com.br /p:$PASS /w:1300 /h:708 /v:$VMIP:3389
#wlfreerdp +window-drag +aero +home-drive  +clipboard  /smart-sizing  /d:AzureAD  /sec:tls  /sound:sys:pulse   /u:vitorrfveloso@outlook.com.br /p:$PASS /w:1300 /h:708 /v:$VMIP:3389

wlfreerdp +window-drag +aero +home-drive  +clipboard  /smart-sizing  /d:AzureAD  /sec:tls  /sound:sys:pulse   /u:user /p:123456 /w:1300 /h:708 /v:$VMIP:3389


#!/bin/bash

#First Time? Store Login Info

#$ secret-tool store --label="RDP_LOCAL" WIN11 USER
#type user
#$ secret-tool store --label="RDP_LOCAL" WIN11 PASS
#type pass

USER=$(secret-tool lookup WIN11 USER)
PASS=$(secret-tool lookup WIN11 PASS)


#sdl-freerdp 
xfreerdp +aero +clipboard +home-drive +auto-reconnect /sound:sys:alsa /v:Win11.lan:3389 /u:$USER /p:$PASS  /w:1350 /h:718 

#!/bin/bash 

OPTIONS=( -aAXv )
EXCLUDE=$( echo \
 --delete \
 --delete-excluded \
 --exclude="/dev/*" \
 --exclude="/proc/*" \
 --exclude="/sys/*" \
 --exclude="/tmp/*" \
 --exclude="/run/*" \
 --exclude="/mnt/*" \
 --exclude="/mnt_bkp/*" \
 --exclude="/media/*" \
 --exclude="/lost+found" \
 --exclude='.snapshots' \
 --exclude='.snapshot' \
 --exclude='$RECYCLE.BIN'  \
 --exclude='$Recycle.Bin'  \
 --exclude='.AppleDB'  \
 --exclude='.AppleDesktop'  \
 --exclude='.AppleDouble'  \
 --exclude='.com.apple.timemachine.supported'  \
 --exclude='.dbfseventsd'  \
 --exclude='.DocumentRevisions-V100*'  \
 --exclude='.DS_Store'  \
 --exclude='.fseventsd'  \
 --exclude='.PKInstallSandboxManager'  \
 --exclude='.Spotlight*'  \
 --exclude='.SymAV*'  \
 --exclude='.symSchedScanLockxz'  \
 --exclude='.TemporaryItems'  \
 --exclude='.Trash*'  \
 --exclude='.vol'  \
 --exclude='.VolumeIcon.icns'  \
 --exclude='hiberfil.sys'  \
 --exclude='lost+found'  \
 --exclude='Network Trash Folder'  \
 --exclude='pagefile.sys'  \
 --exclude='Recycled'  \
 --exclude='RECYCLER'  \
 --exclude='System Volume Information'  \
 --exclude='Temporary Items'  \
 --exclude='AppData'  \
 --exclude='Thumbs.db')

sudo rsync $OPTIONS $EXCLUDE $1 $2 


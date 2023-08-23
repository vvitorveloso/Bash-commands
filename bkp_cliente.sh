#!/bin/bash 

OPTIONS=( -av )
EXCLUDE=$( echo \
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


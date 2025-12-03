#!/bin/bash
secret-tool lookup keepass login |\
 keepassxc --pw-stdin ~/KP/keepass.kdbx \
--keyfile ~/Documentos/key/keepassnew.key > \
 /dev/null 2>&1 &

# secret-tool store --label='KeePassXC' 'keepass' login

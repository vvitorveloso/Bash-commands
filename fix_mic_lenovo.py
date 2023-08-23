#!/usr/bin/env python3

import os
import struct
from fcntl import ioctl

IOCTL_INFO = 0x80dc4801
IOCTL_PVERSION = 0x80044810
IOCTL_VERB_WRITE = 0xc0084811

def set(nid, verb, param):
    verb = (nid << 24) | (verb << 8) | param
    res = ioctl(FD, IOCTL_VERB_WRITE, struct.pack('II', verb, 0))

FD = os.open("/dev/snd/hwC0D0", os.O_RDONLY)
info = struct.pack('Ii64s80si64s', 0, 0, b'', b'', 0, b'')
res = ioctl(FD, IOCTL_INFO, info)
name = struct.unpack('Ii64s80si64s', res)[3]
if not name.decode().startswith('HDA Codec'):
    raise IOError("unknown HDA hwdep interface")

res = ioctl(FD, IOCTL_PVERSION, struct.pack('I', 0))
version = struct.unpack('I', res)[0]
if version < 0x00010000:    # 1.0.0
    raise IOError("unknown HDA hwdep version")

# initialization sequence starts here...

set(0x08, 0x300, 0x50bf) # 0x080350bf (SET_AMP_GAIN_MUTE)

os.close(FD)

#!/bin/bash
#https://github.com/jesusferm/Nautilus-BackSpace

wget "https://raw.githubusercontent.com/jesusferm/Nautilus-BackSpace/refs/heads/main/BackSpaceGnome47.py"
cp BackSpaceGnome47.py ~/.local/share/nautilus-python/extensions
nautilus -q

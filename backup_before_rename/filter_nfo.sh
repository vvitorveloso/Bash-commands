find  /midia/games/emulator/Super_Nintendo -name "*.nfo" -type 'f' -size -3


IFS=$'\n'


#https://askubuntu.com/questions/370024/find-directories-that-dont-contain-a-file-but-yes-another-one PLUS SOME THINGS

for i in $(find /midia/games/emulator/Super_Nintendo -maxdepth 1 -type d '!'   -exec sh -c 'ls -1 "{}"|egrep -iq "^*\.nfo$"' ';' -print); do echo "mv $i "$(dirname "$i")/notok"";done

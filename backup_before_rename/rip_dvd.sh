#!/bin/bash

DIR=$(mount | grep sr0 | cut -d' ' -f 3 )
NAME=$(echo $DIR| cut -d'/' -f5)

rm /tmp/voblist.txt
rm $NAME.mp4

for i in $(ls $DIR/VIDEO_TS | grep VOB);do 

	echo file \'$DIR\/VIDEO_TS\/$i\' >> /tmp/voblist.txt 

done


#ffmpeg -safe 0 \
#-analyzeduration 500M \
#-probesize 500M \
#-f concat -i /tmp/voblist.txt  \
#-c:v libx264 \
#-c:a aac \
#-threads 4 -speed 1  \
#-map 0 -map -0:d -map -0:s -c:s copy \
#$NAME.mp4


ffmpeg -safe 0 \
-analyzeduration 500M \
-probesize 500M \
-f concat -i /tmp/voblist.txt  \
-c:v copy \
-c:a copy \
-c:s copy \
-threads 4 -speed 1  \
-map 0  \
-map -0:d \
$NAME_ALL.vob

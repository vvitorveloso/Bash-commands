#!/bin/bash


rm /tmp/video_file_list.txt
rm $NAME/out.mp4

NAME=$(realpath $1)

for i in $(ls $1 );do 
	echo file \'$NAME/$i\' >> /tmp/video_file_list.txt 
done


ffmpeg -f concat -safe 0 -i /tmp/video_file_list.txt  -c:v libx264 -c:a aac -threads 4 -speed 1 -map 0 -c:s copy $NAME/out.mp4

#!/bin/bash

dirpar=$(dirname $1)
dir=$(basename $1)
echo mkdir $dirpar/image
echo mkdir $dirpar/video
phockup -m -d YYYY/MM --file-type=image     $1 $dirpar/image_$dir
echo phockup -t -m -d YYYY/MM --file-type=image  $1 $dirpar/image_$dir
phockup -m -d YYYY/MM --file-type=video     $1 $dirpar/video_$dir
echo phockup -t -m -d YYYY/MM --file-type=video  $1 $dirpar/video_$dir

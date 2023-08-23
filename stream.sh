#!/usr/bin/bash

YOUTUBE_KEY=""
FACEBOOK_KEY=""

while `true`
do

ffmpeg -v debug -listen 1 -timeout 2000  -i rtmp://127.0.0.1:1935/live/app \
-c copy -f flv  rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY \
-c copy -f flv "rtmps://live-api-s.facebook.com:443/rtmp/$FACEBOOK_KEY"
# tested with simultanly with periscope, in teory add as many as you want

done

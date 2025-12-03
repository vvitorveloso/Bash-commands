#!/bin/bash

IFS=$'\n' 
mkdir workdir

find . -type f -print0 | xargs -0 mv --backup=t  -t workdir/

find . -type d -empty -print -delete


cd workdir/

for i in $(find . -name "*.~*~"  -type f);do ext=$(echo $i| awk -F. '{ print $(NF-1) }') ; mv -n $i $i.$ext ;done

FILE=$(find . -type f -printf "%TY/%Tm/%Td_%TH_%TM_%TS_%f\n")

for i in $FILE;do 

	DIR=$(echo $i |cut -d"/" -f 1-2)

	if [ ! -f $i ];then
		mkdir --parent $DIR
		mv --backup=t $(echo $i | cut -d'_' -f5-99) $i
	else
		echo file exists
	fi

done

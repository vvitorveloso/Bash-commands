#!/bin/bash

IFS=$'\n' 

FILE=$(find . -type f -printf "%TY/%Tm/%Td_%TH_%TM_%TS_%f\n")

for i in $FILE;do 

	DIR=$(echo $i |cut -d"/" -f 1-2)

	if [ ! -f $i ];then
		mkdir --parent $DIR
		mv -n $(echo $i | cut -d'_' -f5-99) $i
	else
		echo file exists
	fi

done

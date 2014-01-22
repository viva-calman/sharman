#!/bin/bash

FILENAME=$1
SUBNAME=$(echo $FILENAME|sed -e 's/\.[a-zA-Z]*$//')

function SearchAndPlay {
	NAME=$1
	SUBNAME=$2
	PATH1=$3
	RESULT=$(ls $PATH1|grep $SUBNAME.srt)
	if [[ -n $RESULT ]]
	then
		echo "SRT subtitle found in ./"$PATH1
		mplayer -sub $PATH1/$SUBNAME.srt $NAME
		exit 0
	fi
	RESULT=$(ls $PATH1|grep $SUBNAME.ass)
	if [[ -n $RESULT ]]
	then
		echo "ASS subtitle found in ./"$PATH1
		mplayer -ass -sub $PATH1/$SUBNAME.ass $NAME
		exit 0
	fi
}

echo "Search subtitles in same folder"
SearchAndPlay $FILENAME $SUBNAME "."
echo "Search subfolders"
SUBFOLDERS=$(ls|grep -i "sub")
for i in $SUBFOLDERS
do
	SearchAndPlay $FILENAME $SUBNAME $i
done
echo "Subtitles not found"
mplayer $FILENAME
exit 0


#!/bin/bash

TESTFOLDER=./tests
TMPFOLDER=./tmp/
R2DECFOLDER=$1

NODE=$(which node)

if [ -z "$R2DECFOLDER" ]; then
	R2DECFOLDER=~/.config/radare2/r2pm/git/r2dec-js/
fi


TESTS=$(find "$TESTFOLDER" | grep ".json" | sed "s/.json//g")

mkdir "$TMPFOLDER"

for ELEM in $TESTS; do
	NAME=$(basename "$ELEM")
	OUTPUTFILE="$TMPFOLDER/$NAME.output.txt"
	$NODE $R2DECFOLDER/main.js "$ELEM.json" > "$OUTPUTFILE" || break
	DIFF=$(diff -u "$ELEM.output.txt" "$OUTPUTFILE")

	if [ ! -z "$DIFF" ]; then
		echo "[XX]: $NAME"
		echo "$DIFF"
	else
		echo "[OK]: $NAME"
		rm "$OUTPUTFILE"
	fi

done

if [ ! "$TMPFOLDER" == "/tmp" ] ; then
	rmdir "$TMPFOLDER"
fi

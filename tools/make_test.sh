#!/bin/bash

FILENAME="$1"
TESTFOLDER="$2"
TMPFOLDER="$3"

if [ $# -eq 3 ]; then
	NAME=$(basename $FILENAME)
	echo "    building: $TESTFOLDER/$NAME.json"
	r2 -A -Q -c "s main; e asm.arch > $TMPFOLDER/arch.txt; agj > $TMPFOLDER/agj.json; isj > $TMPFOLDER/isj.json; izj > $TMPFOLDER/izj.json; aflj > $TMPFOLDER/aflj.json; #!pipe r2dec > $TMPFOLDER/output.txt" "$FILENAME" 2> $TMPFOLDER/stderr.txt
	ARCH=$(cat "$TMPFOLDER/arch.txt")
	AGJ=$(cat "$TMPFOLDER/agj.json")
	ISJ=$(cat "$TMPFOLDER/isj.json")
	IZJ=$(cat "$TMPFOLDER/izj.json")
	AFLJ=$(cat "$TMPFOLDER/aflj.json")
	echo '{"name":"'$NAME'","arch":"'$ARCH'","agj":'$AGJ',"isj":'$ISJ',"izj":'$IZJ',"aflj":'$AFLJ'}' > "$TESTFOLDER/$NAME.$ARCH.json"
	mv "$TMPFOLDER/output.txt" "$TESTFOLDER/$NAME.$ARCH.output.txt"
else
	echo "make_test.sh <file> <test folder> <tmp folder>"
fi


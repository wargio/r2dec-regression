#!/bin/bash

FILENAME="$1"
TESTFOLDER=./tests
TMPFOLDER=./tmp/

echo "Builder:"
echo "  Folders:"
echo "   Temp:   $TMPFOLDER"
echo "   Tests:  $TESTFOLDER"
echo "  Files:"
echo "   List:   $FILENAME"

mkdir "$TMPFOLDER"
mkdir "$TESTFOLDER" 2> $TMPFOLDER/stderr.txt

echo "  Worker output:"
while read LINE; do
	NAME=$(basename $LINE)
	echo "    building: $TESTFOLDER/$NAME.json"
	r2 -Q -c "aaa; s main; e asm.arch > $TMPFOLDER/arch.txt; agj > $TMPFOLDER/agj.json; isj > $TMPFOLDER/isj.json; izj > $TMPFOLDER/izj.json; #!pipe r2dec > $TMPFOLDER/output.txt" "$LINE" 2> $TMPFOLDER/stderr.txt
	ARCH=$(cat "$TMPFOLDER/arch.txt")
	AGJ=$(cat "$TMPFOLDER/agj.json")
	ISJ=$(cat "$TMPFOLDER/isj.json")
	IZJ=$(cat "$TMPFOLDER/izj.json")
	echo '{"name":"'$NAME'","arch":"'$ARCH'","agj":'$AGJ',"isj":'$ISJ',"izj":'$IZJ'}' > "$TESTFOLDER/$NAME.$ARCH.json"
	mv "$TMPFOLDER/output.txt" "$TESTFOLDER/$NAME.$ARCH.output.txt"
done < $FILENAME

if [ ! "$TMPFOLDER" == "/tmp" ]; then
	echo "cleaning working dir.."
	rm -rf "$TMPFOLDER"
fi
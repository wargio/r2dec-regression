#!/bin/bash

FILENAME="$1"
TESTFOLDER=./tests
TMPFOLDER=./tmp
TOOLS=./tools

if [ -z "$FILENAME" ]; then
	echo "usage: builder.sh bins/binaries.lst"
	exit 1
fi

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
	bash $TOOLS/make_test.sh "$LINE" "$TESTFOLDER" "$TMPFOLDER"
done < $FILENAME

if [ ! "$TMPFOLDER" == "/tmp" ]; then
	echo "cleaning working dir.."
	rm -rf "$TMPFOLDER"
fi
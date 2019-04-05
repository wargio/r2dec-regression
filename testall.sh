#!/bin/bash

TESTFOLDER=./tests
TMPFOLDER=./tmp
R2DECFOLDER=$1
TRAVIS=$2
RMCMD="rm -rf"
ERROR=false
DIFF="diff -u"

if [ -z "$TRAVIS" ]; then
	RMCMD="rmdir"
	DIFF="diff --color=always -u"
fi

if [ -z "$R2DECFOLDER" ]; then
	R2DECFOLDER=~/.local/share/radare2/r2pm/git/r2dec-js
fi

R2DECBINFLD=$R2DECFOLDER/p

if [ ! -f "$R2DECBINFLD/r2dec-test" ]; then
	echo "building binary src"
    make --no-print-directory testbin -C "$R2DECBINFLD"
fi

TESTS=$(find "$TESTFOLDER" | grep ".json" | sed "s/.json//g")

mkdir "$TMPFOLDER"

for ELEM in $TESTS; do
	NAME=$(basename "$ELEM")
	OUTPUTFILE="$TMPFOLDER/$NAME.output.txt"
	$R2DECBINFLD/r2dec-test "$R2DECFOLDER" "$ELEM.json" > "$OUTPUTFILE" || break
	DIFFOUTPUT=$(diff -u "$ELEM.output.txt" "$OUTPUTFILE")

	if [ ! -z "$DIFFOUTPUT" ]; then
		echo "[XX]: $NAME"
		$DIFF "$ELEM.output.txt" "$OUTPUTFILE"
		ERROR=true
	else
		echo "[OK]: $NAME"
		rm "$OUTPUTFILE"
	fi

done

if [ ! "$TMPFOLDER" == "/tmp" ] ; then
	$RMCMD "$TMPFOLDER"
fi


if $ERROR; then
	exit 1;
fi

if [ -f "$R2DECBINFLD/r2dec-test" ]; then
	echo "cleaning binary folder"
    make --no-print-directory clean -C "$R2DECBINFLD"
fi

exit 0;

#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TESTFOLDER=./tests
TMPFOLDER=./tmp
R2DEC=$1
TRAVIS=$2
RMCMD="rm -rf"
ERROR=false
DIFF="diff -u"

if [ -z "$TRAVIS" ]; then
	RMCMD="rmdir"
	DIFF="diff --color=always -u"
fi

if [ -z "$R2DEC" ]; then
	echo "$0 <r2dec folder> <ci>"
	exit 1
fi

. "$SCRIPT_DIR/common.sh"

build_testsuite "$R2DEC"

TESTS=$(find "$TESTFOLDER" -name "*.json" | sed "s/.json//g")

mkdir "$TMPFOLDER"

for ELEM in $TESTS; do
	NAME=$(basename "$ELEM")
	OUTPUTFILE="$TMPFOLDER/$NAME.output.txt"
	run_test "$R2DEC" "$ELEM.json" > "$OUTPUTFILE" || break
	DIFFOUTPUT=$(diff -u "$ELEM.output.txt" "$OUTPUTFILE")

	if [ ! -z "$DIFFOUTPUT" ]; then
		echo "[XX]: $NAME"
		$DIFF "$ELEM.output.txt" "$OUTPUTFILE"
		ERROR=true
		break
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

exit 0;

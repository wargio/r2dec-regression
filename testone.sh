#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TESTFOLDER=./tests
TMPFOLDER=./tmp
R2DEC=$2
TESTNAME=$1
RMCMD="rmdir"
ERROR=false
DIFF="diff --color=always -u"

if [ -z "$TESTNAME" ] || [ -z "$R2DEC" ]; then
	echo "$0 <test name> <r2dec folder>"
	exit 1
fi

. "$SCRIPT_DIR/common.sh"

build_testsuite "$R2DEC"

ELEM=$(find "$TESTFOLDER" | grep "$TESTNAME*.json" | sed "s/.json//g")

if [ ! -d "$TMPFOLDER" ]; then
	mkdir "$TMPFOLDER"
fi

NAME=$(basename "$ELEM")
if [ -z "$NAME" ]; then
	echo "Empty name.."
	exit 1;
fi

OUTPUTFILE="$TMPFOLDER/$NAME.output.txt"
run_test "$R2DEC" "$ELEM.json" > "$OUTPUTFILE" || break
if [ ! -f "$ELEM.output.txt" ]; then
	touch "$ELEM.output.txt"
fi

DIFFOUTPUT=$(diff -u "$ELEM.output.txt" "$OUTPUTFILE")

if [ ! -z "$DIFFOUTPUT" ]; then
	echo "[XX]: $NAME"
	$DIFF "$ELEM.output.txt" "$OUTPUTFILE"
	ERROR=true
else
	echo "[OK]: $NAME"
	rm "$OUTPUTFILE"
fi

if [ ! "$TMPFOLDER" == "/tmp" ] ; then
	$RMCMD "$TMPFOLDER" 2> /dev/null
fi

if $ERROR; then
	exit 1;
fi

exit 0;

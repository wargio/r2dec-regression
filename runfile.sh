#!/bin/bash

TESTFOLDER=./tests
TMPFOLDER=./tmp
R2DECFOLDER=$2
TESTNAME=$1
RMCMD="rmdir"
ERROR=false
DIFF="diff --color=always -u"

if [ -z "$R2DECFOLDER" ]; then
	R2DECFOLDER=~/.local/share/radare2/r2pm/git/r2dec-js
fi

R2DECBINFLD=$R2DECFOLDER/p

if [ ! -f "$R2DECBINFLD/r2dec-test" ]; then
	echo "building binary src"
    make --no-print-directory testbin -C "$R2DECBINFLD"
fi

if [ -z "$TESTNAME" ]; then
	echo "Empty name.."
	exit 1;
fi

$R2DECBINFLD/r2dec-test "$R2DECFOLDER" "$TESTNAME"


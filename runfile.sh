#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
R2DEC="$2"
TESTNAME="$1"

if [ -z "$R2DEC" ]; then
	echo "$0 <file.json> <r2dec folder>"
	exit 1
fi

. "$SCRIPT_DIR/common.sh"

build_testsuite "$R2DEC"

if [ -z "$TESTNAME" ]; then
	echo "Empty name.."
	exit 1;
fi

run_test "$R2DEC" "$TESTNAME"


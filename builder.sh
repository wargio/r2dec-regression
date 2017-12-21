#!/bin/bash

FILENAME="$1"

echo "$FILENAME"

mkdir tests 2> /dev/null || echo "tests already created"
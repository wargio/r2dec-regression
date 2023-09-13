build_testsuite() {
	local r2dec="$1"
	local BUILD="$r2dec/build-standalone"
	local BIN="$BUILD/r2dec-standalone"
	local WORKDIR="$PWD"

	if [ ! -d "$r2dec" ]; then
		echo "Error: '$r2dec' is not a valid directory"
		exit 1
	fi

	if [ ! -d "$BUILD" ]; then
		echo "Info: creating meson build '$BUILD'"
		cd "$r2dec"
		meson -Dstandalone=true "build-standalone" || exit 1
		ninja -C "build-standalone" || exit 1
		cd "$WORKDIR"
	elif [ ! -f "$BIN" ]; then
		echo "Info: rebuilding '$BIN'"
		cd "$r2dec"
		ninja -C "build-standalone" || exit 1
		cd "$WORKDIR"
	fi
}

run_test() {
	local r2dec="$1"
	local JSON="$2"
	local BIN="$r2dec/build-standalone/r2dec-standalone"
	$BIN "$JSON"
	return $?
}


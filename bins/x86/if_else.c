#include <stdio.h>

int main(int argc, char const *argv[]) {
	int var = 0xdead;
	if (var != 0xbeef) {
		var = 0xbeef;
	} else {
		var += 0x2000;
	}
	var += 0x10;
	return 0;
}
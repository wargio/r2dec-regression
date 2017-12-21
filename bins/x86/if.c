#include <stdio.h>

int main(int argc, char const *argv[]) {
	int var = 0xdead;
	if (var != 0xbeef) {
		var = 0xbeef;
	}
	var += 0x10;
	return 0;
}
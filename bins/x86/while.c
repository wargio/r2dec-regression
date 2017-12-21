#include <stdio.h>

int main(int argc, char const *argv[]) {
	int var = 0;
	while(var < 0x90) {
		var += 0x50;
	}
	return 0;
}
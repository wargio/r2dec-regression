#include <stdio.h>

int main(int argc, char const *argv[]) {
	int var = 0;
	int var2 = 0x1234;
	while(var < 0x90) {
		var = 0x30;
		var += 0x50;
		while(var2 > 0x30) {
			var2--;
		}
	}
	return 0;
}
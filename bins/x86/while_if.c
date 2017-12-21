#include <stdio.h>

int main(int argc, char const *argv[]) {
	int var = 0;
	while(var < 0x90) {
		if(var < 0x10) {
			var += 0x50;
		}
		var += 0x10;
	}
	return 0;
}
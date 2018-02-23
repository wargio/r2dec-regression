#include <stdio.h>

int main(int argc, char const *argv[]) {
	int var = 0;
	while(var < 0x90) {
		if(var > 0x40) {
			var += 0x07;
		} else if(var > 0x50) {
			var += 0x05;
		} else {
			var -= 0x1;
		}
		var += 0x10;
	}
	var += 0x15;
	return 0;
}
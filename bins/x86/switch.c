#include <stdio.h>

int random() {
	return 4;
}

int main(int argc, char const *argv[]) {
	switch(random()) {
		case 0:
			return 0x1111;
		case 1:
			return 0x2222;
		case 3:
			return 0x3333;
		case 0xae:
			return 0x1122;
		case -5:
			return 0x9999;
		default:
			break;
	}
	return 0;
}
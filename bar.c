#include "foo.h"
#include <stdio.h>

int main(void) {
	if (!DidInitRun()) {
		fprintf(stderr, "ERROR: buildmode=c-archive init should run\n");
		return 2;
	}
	fprintf(stderr, "PASS\n");
	return 0;
}

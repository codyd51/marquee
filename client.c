#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <memory.h>

#include "marquee.h"

#define VIEWPORT_WIDTH 150
#define VIEWPORT_HEIGHT 12
bool viewport[VIEWPORT_HEIGHT][VIEWPORT_WIDTH] = {0};

void mq_px_on(int x, int y) {
		if (!mq_verify_coord(x, y)) return;
		viewport[y][x] = 1;
}

void mq_px_off(int x, int y) {
		if (!mq_verify_coord(x, y)) return;
		viewport[y][x] = 0;
}

void print_viewport(void);

void mq_time_step(void) {
		usleep(25000);
		print_viewport();
}

void print_viewport(void) {
		printf("\033[2J");
		for (int y = 0; y < VIEWPORT_HEIGHT; y++) {
				for (int x = 0; x < VIEWPORT_WIDTH; x++) {
						if (viewport[y][x]) {
								putchar('$');
						}
						else {
								putchar('.');
						}
				}
				putchar('\n');
		}
		putchar('\n');
}

int main(int argc, char** argv) {
		memset(viewport, 0, sizeof(viewport));
		mq_init(VIEWPORT_WIDTH, VIEWPORT_HEIGHT);

		char* msg = "This is some scrolling text.";
		render_string(msg, strlen(msg), 20, 1);

		return 0;
}


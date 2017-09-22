#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <memory.h>
#include "font8x8_basic.h"

void mq_px_on(int x, int y);
void mq_px_off(int x, int y);

#define VIEWPORT_WIDTH 100
#define VIEWPORT_HEIGHT 9
bool viewport[VIEWPORT_HEIGHT][VIEWPORT_WIDTH] = {0};

int mq_width(void) {
	return VIEWPORT_WIDTH;
}

int mq_height(void) {
	return VIEWPORT_HEIGHT;
}

bool verify_coord(int x, int y) {
	if (x < 0 ||
	    x >= mq_width() ||
	    y < 0 ||
	    y >= mq_height()) {
		return false;
	}
	return true;
}

void render_char(char ch, int x, int y) {
		char* bitmap = font8x8_basic[ch];
		for (int i = 0; i < 8; i++) {
				char val = bitmap[i];
				for (int j = 0; j < 8; j++) {
						if ((val >> j) & 1) {
								mq_px_on(x + j, y + i);
						}
						else {
								mq_px_off(x + j, y + i);
						}
				}
		}
}

void render_string(char* str, uint32_t len, int x, int y) {
	char* p = str;
#define FONT_WIDTH 8
#define FONT_HEIGHT 8
	while (*p && (len--) != 0) {
			render_char(*p, x, y);
			x += FONT_WIDTH;
			p++;
	}
}

void mq_px_on(int x, int y) {
	if (!verify_coord(x, y)) return;
	viewport[y][x] = 1;
}

void mq_px_off(int x, int y) {
	if (!verify_coord(x, y)) return;
	viewport[y][x] = 0;
}

void print_viewport(void) {
	for (int y = 0; y < VIEWPORT_HEIGHT; y++) {
		for (int x = 0; x < VIEWPORT_WIDTH; x++) {
			printf("%d", (int)viewport[y][x]);
		}
		printf("\n");
	}
}

int main(int argc, char** argv) {
	memset(viewport, 0, sizeof(viewport));

	/*
	for (int i = '!'; i < '~'; i++) {
			printf("\n%c: \n", i);
			render_char(i, 0, 0);
			print_viewport();
			usleep(2000 * 1000);
	}
	*/

	char* msg = "Hello World!";
	render_string(msg, strlen(msg), 1, 1);
	print_viewport();

	return 0;
}

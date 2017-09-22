#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <memory.h>
#include "marquee.h"
#include "font8x8_basic.h"

#define UNSCALED_FONT_WIDTH  8
#define UNSCALED_FONT_HEIGHT 8

void mq_px_on(int x, int y);
void mq_px_off(int x, int y);

static int mq_width = 0;
static int mq_height = 0;

void mq_init(int width, int height) {
		mq_width = width;
		mq_height = height;
}

bool verify_coord(int x, int y) {
		if (x < 0 ||
			x >= mq_width ||
			y < 0 ||
			y >= mq_height) {
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
		while (*p && (len--) != 0) {
				render_char(*p, x, y);
				x += UNSCALED_FONT_WIDTH;
				p++;
		}
}


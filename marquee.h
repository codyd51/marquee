#ifndef MARQUEE_H
#define MARQUEE_H

#include <stdint.h>

void mq_init(int width, int height);
bool mq_verify_coord(int x, int y);
void render_char(char ch, int x, int y);
void render_string(char* str, uint32_t len, int x, int y);

#endif

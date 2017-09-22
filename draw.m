#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "marquee.h"

static NSBitmapImageRep* rep = nil;
static NSColor* white = nil;
static NSColor* black = nil;
static NSImageView* imageView = nil;
static NSRect viewport_rect;

void mq_px_on(int x, int y) {
	if (!rep) return;
	if (!mq_verify_coord(x, y)) return;
	[rep setColor:black atX:x y:y];
}

void mq_px_off(int x, int y) {
	if (!rep) return;
	if (!mq_verify_coord(x, y)) return;
	[rep setColor:white atX:x y:y];
}

void mq_time_step(void) {
		usleep(20000);
		NSImage* img = [[NSImage alloc] initWithCGImage:[rep CGImage] size:viewport_rect.size];
		[imageView setImage:img];
}

int main(int argc, char** argv) {
	viewport_rect = NSMakeRect(200, 200, 150, 12);
	mq_init(viewport_rect.size.width, viewport_rect.size.height);

	@autoreleasepool {
		white = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
		black = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0];

		NSApplication* app = [NSApplication sharedApplication];
		[NSApp activateIgnoringOtherApps:YES];
		NSWindow* win = [[NSWindow alloc] initWithContentRect:viewport_rect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];

		rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil 
														  pixelsWide:viewport_rect.size.width 
														  pixelsHigh:viewport_rect.size.height 
														  bitsPerSample:8 
														  samplesPerPixel:4 
														  hasAlpha:YES 
														  isPlanar:NO 
														  colorSpaceName:NSCalibratedRGBColorSpace 
														  bitmapFormat:0 
														  bytesPerRow:(4 * viewport_rect.size.width) 
														  bitsPerPixel:32];
		imageView = [[NSImageView alloc] initWithFrame:viewport_rect];
		[win setContentView:imageView];

		[win setLevel:NSPopUpMenuWindowLevel];
		[win makeKeyAndOrderFront:nil];

		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
		dispatch_async(queue, ^{
				char* msg = "Hello world! Graphical demo of marquee";
				render_string(msg, strlen(msg), 50, 2);
		});

		[app run];
	}
	return 0;
}


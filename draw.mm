#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

int main(int argc, char** argv) {
	NSRect viewport_rect = NSMakeRect(0, 0, 100, 100);

	@autoreleasepool {
		NSApplication* app = [NSApplication sharedApplication];

		[NSApp activateIgnoringOtherApps:YES];
		NSWindow* win = [[NSWindow alloc] initWithContentRect:viewport_rect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];

		NSBitmapImageRep* rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil 
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
		[NSGraphicsContext saveGraphicsState];
		[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
		
		for (int y = 0; y < viewport_rect.size.height; y++) {
			for (int x = 0; x < viewport_rect.size.width; x++) {
				NSColor *col = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
				if (x % 2) {
					col = [NSColor colorWithCalibratedRed:1 green:0 blue:0.5 alpha:1.0];
				}
				[rep setColor:col atX:x y:y];
			}
		}
	
		[NSGraphicsContext restoreGraphicsState];

		NSImage* img = [[NSImage alloc] initWithCGImage:[rep CGImage] size:viewport_rect.size];
		NSImageView* view = [[NSImageView alloc] initWithFrame:viewport_rect];
		[view setImage:img];
		[win setContentView:view];

		[win makeKeyAndOrderFront:nil];

		[app run];
	}
	return 0;
}

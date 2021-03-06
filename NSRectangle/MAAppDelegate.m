//
//  MAAppDelegate.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MAAppDelegate.h"

#import "MARectangle.h"
#import "NSScreen+MARectangleAdditions.h"
#import "NSView+MARectangleAdditions.h"
#import "NSWindow+MARectangleAdditions.h"


@interface TestView : NSView @end
@implementation TestView

- (void)drawRect: (NSRect)r
{
    NSRect bounds = [self bounds];
    [[NSColor redColor] setStroke];
    [NSBezierPath strokeLineFromPoint: bounds.origin toPoint: NSMakePoint(NSMaxX(bounds), NSMaxY(bounds))];
}

@end

@implementation MAAppDelegate {
    NSWindow *w;
}

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    TestView *v = [[TestView alloc] init];
    [[_window contentView] addSubview: v];
    [v ma_setFrameRectangle: [[_window contentView] ma_frameRectangle]];
    
    MARectangle *newWindowRect = [[v ma_frameRectangle] withSize: [MASize sizeWithNSSize: NSMakeSize(50, 50) coordinateSystem: [NSScreen ma_coordinateSystem]]];
    w = [[NSWindow alloc] initWithContentMARectangle: newWindowRect styleMask: NSTitledWindowMask backing: NSBackingStoreBuffered defer: YES];
    TestView *v2 = [[TestView alloc] init];
    [[w contentView] addSubview: v2];
    [v2 ma_setFrameRectangle: [[w contentView] ma_frameRectangle]];
    [w makeKeyAndOrderFront: nil];
}

@end

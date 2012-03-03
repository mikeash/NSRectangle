//
//  MAAppDelegate.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MAAppDelegate.h"

#import "NSView+MARectangleAdditions.h"
#import "NSWindow+MARectangleAdditions.h"


@interface TestView : NSView @end
@implementation TestView

- (void)drawRect: (NSRect)r
{
    [[NSColor redColor] setStroke];
    [NSBezierPath strokeLineFromPoint: r.origin toPoint: NSMakePoint(NSMaxX(r), NSMaxY(r))];
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
    
    w = [[NSWindow alloc] initWithContentMARectangle: [v ma_frameRectangle] styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    TestView *v2 = [[TestView alloc] init];
    [[w contentView] addSubview: v2];
    [v2 ma_setFrameRectangle: [v ma_frameRectangle]];
    [w orderFront: nil];
}

@end

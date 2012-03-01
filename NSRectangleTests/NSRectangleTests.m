//
//  NSRectangleTests.m
//  NSRectangleTests
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSRectangleTests.h"

#import "MACoordinateSystem.h"
#import "MARectangle.h"


@implementation NSRectangleTests

- (void)testSameViewPointSize
{
    NSPoint p = { 1, 2 };
    NSSize s = { 3, 4 };
    
    NSWindow *w = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    [[w contentView] addSubview: v];
    
    MAPoint *pobj = [MAPoint pointWithNSPoint: p coordinateSystem: [[MACoordinateSystem alloc] initWithView: v]];
    MASize *sobj = [MASize sizeWithNSSize: s coordinateSystem: [[MACoordinateSystem alloc] initWithView: v]];
    
    STAssertEquals(p, [pobj pointValueInCoordinateSystem: [[MACoordinateSystem alloc] initWithView: v]], @"Points are not equal");
    STAssertEquals(s, [sobj sizeValueInCoordinateSystem: [[MACoordinateSystem alloc] initWithView: v]], @"Sizes are not equal");
}

@end

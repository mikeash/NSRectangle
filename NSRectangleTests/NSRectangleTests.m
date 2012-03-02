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

- (void)testDifferentViewPoint
{
    NSPoint p = { 1, 2 };
    
    NSWindow *w = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    NSView *v2 = [[NSView alloc] initWithFrame: NSMakeRect(50, 50, 100, 100)];
    [[w contentView] addSubview: v];
    [[w contentView] addSubview: v2];
    
    MAPoint *pobj = [MAPoint pointWithNSPoint: p coordinateSystem: [[MACoordinateSystem alloc] initWithView: v]];
    
    STAssertEquals(NSMakePoint(-49, -48), [pobj pointValueInCoordinateSystem: [[MACoordinateSystem alloc] initWithView: v2]], @"Points are not equal");
}

- (void)testDifferentViewSize
{
    NSSize s = { 1, 2 };
    
    NSWindow *w = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    NSView *v2 = [[NSView alloc] initWithFrame: NSMakeRect(50, 50, 100, 100)];
    [v2 scaleUnitSquareToSize: NSMakeSize(2, 2)];
    [[w contentView] addSubview: v];
    [[w contentView] addSubview: v2];
    
    MASize *sobj = [MASize sizeWithNSSize: s coordinateSystem: [[MACoordinateSystem alloc] initWithView: v]];
    
    STAssertEquals(NSMakeSize(0.5, 1), [sobj sizeValueInCoordinateSystem: [[MACoordinateSystem alloc] initWithView: v2]], @"Sizes are not equal");
}

- (void)testDifferentWindowPoint
{
    NSPoint p = { 1, 2 };
    
    NSWindow *w = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    [[w contentView] addSubview: v];
    NSWindow *w2 = [[NSWindow alloc] initWithContentRect: NSMakeRect(50, 50, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v2 = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    [[w2 contentView] addSubview: v2];
    
    MAPoint *pobj = [MAPoint pointWithNSPoint: p coordinateSystem: [[MACoordinateSystem alloc] initWithView: v]];
    
    STAssertEquals(NSMakePoint(-49, -48), [pobj pointValueInCoordinateSystem: [[MACoordinateSystem alloc] initWithView: v2]], @"Points are not equal");
}

- (void)testDifferentWindowSize
{
    NSSize s = { 1, 2 };
    
    NSWindow *w = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    [[w contentView] addSubview: v];
    
    NSWindow *w2 = [[NSWindow alloc] initWithContentRect: NSMakeRect(50, 50, 100, 100) styleMask: 0 backing: NSBackingStoreBuffered defer: YES];
    NSView *v2 = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    [v2 scaleUnitSquareToSize: NSMakeSize(2, 2)];
    [[w2 contentView] addSubview: v2];
    
    MASize *sobj = [MASize sizeWithNSSize: s coordinateSystem: [[MACoordinateSystem alloc] initWithView: v]];
    
    STAssertEquals(NSMakeSize(0.5, 1), [sobj sizeValueInCoordinateSystem: [[MACoordinateSystem alloc] initWithView: v2]], @"Sizes are not equal");
}

@end

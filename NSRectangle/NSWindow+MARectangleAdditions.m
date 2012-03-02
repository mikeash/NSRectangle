//
//  NSWindow+MARectangleAdditions.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSWindow+MARectangleAdditions.h"

#import "MACoordinateSystem.h"
#import "MARectangle.h"
#import "NSScreen+MARectangleAdditions.h"


@implementation NSWindow (MARectangleAdditions)

- (id)initWithContentMARectangle: (MARectangle *)contentRectangle styleMask: (NSUInteger)aStyle backing: (NSBackingStoreType)bufferingType defer: (BOOL)flag
{
    NSRect r = [contentRectangle rectValueInCoordinateSystem: [NSScreen ma_coordinateSystem]];
    return [self initWithContentRect: r styleMask: aStyle backing: bufferingType defer: flag];
}

- (MACoordinateSystem *)ma_coordinateSystem
{
    return [[MACoordinateSystem alloc] initWithWindow: self];
}

- (MARectangle *)frameRectangle
{
    return [MARectangle rectangleWithRect: [self frame] coordinateSystem: [NSScreen ma_coordinateSystem]];
}

- (void)setFrameRectangle: (MARectangle *)rect
{
    NSRect r = [rect rectValueInCoordinateSystem: [NSScreen ma_coordinateSystem]];
    [self setFrame: r display: YES];
}

@end

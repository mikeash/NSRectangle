//
//  NSView+MARectangleAdditions.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSView+MARectangleAdditions.h"

#import "MACoordinateSystem.h"
#import "MARectangle.h"


@implementation NSView (MARectangleAdditions)

- (MACoordinateSystem *)ma_coordinateSystem
{
    return [[MACoordinateSystem alloc] initWithView: self];
}

- (MARectangle *)ma_frameRectangle
{
    return [MARectangle rectangleWithRect: [self bounds] coordinateSystem: [self ma_coordinateSystem]];
}

- (void)ma_setFrameRectangle: (MARectangle *)rect
{
    NSRect r = [rect rectValueInCoordinateSystem: [self ma_coordinateSystem]];
    r = [self convertRect: r toView: [self superview]];
    [self setFrame: r];
}

@end

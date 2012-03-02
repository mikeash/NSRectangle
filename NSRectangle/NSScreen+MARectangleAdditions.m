//
//  NSScreen+MARectangleAdditions.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSScreen+MARectangleAdditions.h"

#import "MACoordinateSystem.h"


@implementation NSScreen (MARectangleAdditions)

+ (MACoordinateSystem *)ma_coordinateSystem
{
    static MACoordinateSystem *coordinateSystem;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        coordinateSystem = [[MACoordinateSystem alloc] initWithScreenCoordinateSystem];
    });
    return coordinateSystem;
}

@end

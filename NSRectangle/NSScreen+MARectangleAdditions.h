//
//  NSScreen+MARectangleAdditions.h
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MACoordinateSystem;


@interface NSScreen (MARectangleAdditions)

+ (MACoordinateSystem *)ma_coordinateSystem;

@end

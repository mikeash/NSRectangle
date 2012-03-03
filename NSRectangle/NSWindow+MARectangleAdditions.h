//
//  NSWindow+MARectangleAdditions.h
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MACoordinateSystem;
@class MARectangle;

@interface NSWindow (MARectangleAdditions)

- (id)initWithContentMARectangle: (MARectangle *)contentRectangle styleMask: (NSUInteger)aStyle backing: (NSBackingStoreType)bufferingType defer: (BOOL)flag;

- (MACoordinateSystem *)ma_coordinateSystem;
- (MARectangle *)ma_frameRectangle;
- (void)ma_setFrameRectangle: (MARectangle *)rect;

@end

//
//  MACoordinateSystem.h
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MACoordinateSystem : NSObject

- (instancetype)init; // designated initializer, creates a screen coordinate system
- (instancetype)initWithScreenCoordinateSystem;
- (instancetype)initWithWindow: (NSWindow *)window;
- (instancetype)initWithView: (NSView *)view;

- (NSWindow *)window;
- (NSView *)view;

- (NSPoint)convertPoint: (NSPoint)p toCoordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (NSSize)convertSize: (NSSize)s toCoordinateSystem: (MACoordinateSystem *)coordinateSystem;

@end

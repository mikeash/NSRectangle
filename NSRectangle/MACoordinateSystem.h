//
//  MACoordinateSystem.h
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MACoordinateSystem : NSObject

- (instancetype)initWithScreenCoordinateSystem;
- (instancetype)initWithWindow: (NSWindow *)window;
- (instancetype)initWithView: (NSView *)view;

- (NSRect)convertRect: (NSRect)r toCoordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (NSPoint)convertPoint: (NSPoint)p toCoordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (NSSize)convertSize: (NSSize)s toCoordinateSystem: (MACoordinateSystem *)coordinateSystem;

@end

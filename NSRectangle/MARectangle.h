//
//  MARectangle.h
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class MACoordinateSystem;

@interface MATwoElementCoordinate : NSObject

- (instancetype)initWithElements: (CGFloat[2])elements coordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (CGFloat *)elements;
- (MACoordinateSystem *)coordinateSystem;

@end

@interface MAPoint : MATwoElementCoordinate

+ (instancetype)pointWithNSPoint: (NSPoint)p coordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (NSPoint)pointValueInCoordinateSystem: (MACoordinateSystem *)coordinateSystem;

@end

@interface MASize : MATwoElementCoordinate

+ (instancetype)sizeWithNSSize: (NSSize)s coordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (NSSize)sizeValueInCoordinateSystem: (MACoordinateSystem *)coordinateSystem;

@end


@interface MARectangle : NSObject

+ (instancetype)rectangleWithRect: (NSRect)r coordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (instancetype)initWithRect: (NSRect)r coordinateSystem: (MACoordinateSystem *)coordinateSystem;

- (NSRect)rectValueInCoordinateSystem: (MACoordinateSystem *)coordinateSystem;

- (instancetype)byAddingSizeToOrigin: (MASize *)size;

- (instancetype)byAddingX: (CGFloat)delta;
- (instancetype)byAddingX: (CGFloat)delta inCoordinateSystem: (MACoordinateSystem *)coordinateSystem;
- (instancetype)byAddingY: (CGFloat)delta;
- (instancetype)byAddingY: (CGFloat)delta inCoordinateSystem: (MACoordinateSystem *)coordinateSystem;

- (instancetype)withOrigin: (MAPoint *)point;
- (instancetype)withSize: (MASize *)size;

@end

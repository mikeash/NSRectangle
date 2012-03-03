//
//  MARectangle.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MARectangle.h"

#import "MACoordinateSystem.h"


@implementation MATwoElementCoordinate {
    @protected
    CGFloat _elements[2];
    MACoordinateSystem *_coordinateSystem;
}

- (instancetype)initWithElements: (CGFloat[2])elements coordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    if((self = [super init]))
    {
        memcpy(_elements, elements, sizeof(_elements));
        _coordinateSystem = coordinateSystem;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"<%@ %p: (%f, %f) %@>", [self class], self, _elements[0], _elements[1], _coordinateSystem];
}

- (CGFloat *)elements
{
    return _elements;
}

- (MACoordinateSystem *)coordinateSystem
{
    return _coordinateSystem;
}

@end

@implementation MAPoint

+ (instancetype)pointWithNSPoint: (NSPoint)p coordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    return [[self alloc] initWithElements: (CGFloat *)&p coordinateSystem: coordinateSystem];
}

- (NSPoint)pointValueInCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    NSPoint point = *(NSPoint *)_elements;
    return [_coordinateSystem convertPoint: point toCoordinateSystem: coordinateSystem];
}

@end

@implementation MASize

+ (instancetype)sizeWithNSSize: (NSSize)s coordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    return [[self alloc] initWithElements: (CGFloat *)&s coordinateSystem: coordinateSystem];
}

- (NSSize)sizeValueInCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    NSSize size = *(NSSize *)_elements;
    return [_coordinateSystem convertSize: size toCoordinateSystem: coordinateSystem];
}

@end

@implementation MARectangle {
    NSRect _r;
    MACoordinateSystem *_coordinateSystem;
}

+ (instancetype)rectangleWithRect: (NSRect)r coordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    return [[self alloc] initWithRect: r coordinateSystem: coordinateSystem];
}

- (instancetype)initWithRect: (NSRect)r coordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    if((self = [super init]))
    {
        _r = r;
        _coordinateSystem = coordinateSystem;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"<%@ %p: %@ %@>", [self class], self, NSStringFromRect(_r), _coordinateSystem];
}

- (NSRect)rectValueInCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    return [_coordinateSystem convertRect: _r toCoordinateSystem: coordinateSystem];
}

- (instancetype)addSizeToOrigin: (MASize *)size
{
    NSSize delta = [size sizeValueInCoordinateSystem: _coordinateSystem];
    NSRect newR = NSOffsetRect(_r, delta.width, delta.height);
    return [[self class] rectangleWithRect: newR coordinateSystem: _coordinateSystem];
}

- (instancetype)addX: (CGFloat)delta
{
    return [self addX: delta inCoordinateSystem: _coordinateSystem];
}

- (instancetype)addX: (CGFloat)delta inCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    MASize *size = [MASize sizeWithNSSize: NSMakeSize(delta, 0) coordinateSystem: coordinateSystem];
    return [self addSizeToOrigin: size];
}

- (instancetype)addY: (CGFloat)delta
{
    return [self addY: delta inCoordinateSystem: _coordinateSystem];
}

- (instancetype)addY: (CGFloat)delta inCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    MASize *size = [MASize sizeWithNSSize: NSMakeSize(0, delta) coordinateSystem: coordinateSystem];
    return [self addSizeToOrigin: size];
}

- (instancetype)setOrigin: (MAPoint *)point
{
    NSPoint origin = [point pointValueInCoordinateSystem: _coordinateSystem];
    NSRect newR = { origin, _r.size };
    return [[self class] rectangleWithRect: newR coordinateSystem: _coordinateSystem];
}

- (instancetype)setSize: (MASize *)size
{
    NSSize s = [size sizeValueInCoordinateSystem: _coordinateSystem];
    NSRect newR = { _r.origin, s };
    return [[self class] rectangleWithRect: newR coordinateSystem: _coordinateSystem];
}

@end

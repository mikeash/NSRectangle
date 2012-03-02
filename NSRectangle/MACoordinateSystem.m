//
//  MACoordinateSystem.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MACoordinateSystem.h"

@protocol _MACoordinateAdjacentConversion

- (NSRect)MACoordinateAdjacentConversion_convertRect: (NSRect)r to: (id <_MACoordinateAdjacentConversion>)target;

- (void)MACoordinateAdjacentConversion_enumerateConversionChainTo: (id <_MACoordinateAdjacentConversion>)target withBlock: (void (^)(id <_MACoordinateAdjacentConversion> nextTarget))block;

- (BOOL)MACoordinateAdjacentConversion_isView;
- (BOOL)MACoordinateAdjacentConversion_isWindow;
- (BOOL)MACoordinateAdjacentConversion_isScreen;

@end

@interface _MACoordinateSystemScreen : NSObject <_MACoordinateAdjacentConversion>
+ (_MACoordinateSystemScreen *)screen;
@end
@interface NSWindow (_MACoordinateAdjacentConversion) <_MACoordinateAdjacentConversion>
@end
@interface NSView (_MACoordinateAdjacentConversion) <_MACoordinateAdjacentConversion>
@end

@implementation _MACoordinateSystemScreen

+ (_MACoordinateSystemScreen *)screen
{
    static _MACoordinateSystemScreen *screen;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{ screen = [[self alloc] init]; });
    return screen;
}

- (NSRect)MACoordinateAdjacentConversion_convertRect: (NSRect)r to: (id <_MACoordinateAdjacentConversion>)target
{
    if([target MACoordinateAdjacentConversion_isScreen])
        return r;
    else if([target MACoordinateAdjacentConversion_isWindow])
        return [(NSWindow *)target convertRectFromScreen: r];
    
    NSLog(@"Cannot convert directly from screen to target %@", target);
    abort();
}

- (void)MACoordinateAdjacentConversion_enumerateConversionChainTo: (id <_MACoordinateAdjacentConversion>)target withBlock: (void (^)(id <_MACoordinateAdjacentConversion> nextTarget))block
{
    if([target MACoordinateAdjacentConversion_isWindow])
    {
        block(target);
    }
    else if([target MACoordinateAdjacentConversion_isView])
    {
        block([(NSView *)target window]);
        [target MACoordinateAdjacentConversion_enumerateConversionChainTo: target withBlock: block];
    }
}

- (BOOL)MACoordinateAdjacentConversion_isView
{
    return NO;
}

- (BOOL)MACoordinateAdjacentConversion_isWindow
{
    return NO;
}

- (BOOL)MACoordinateAdjacentConversion_isScreen
{
    return YES;
}

@end

@implementation NSWindow (_MACoordinateAdjacentConversion)

- (NSRect)MACoordinateAdjacentConversion_convertRect: (NSRect)r to: (id <_MACoordinateAdjacentConversion>)target
{
    if([target MACoordinateAdjacentConversion_isScreen])
        return [self convertRectToScreen: r];
    else if([target MACoordinateAdjacentConversion_isView])
        return [(NSView *)target convertRect: r fromView: nil];
    
    NSLog(@"Cannot convert directly from window %@ to target %@", self, target);
    abort();
}

- (void)MACoordinateAdjacentConversion_enumerateConversionChainTo: (id <_MACoordinateAdjacentConversion>)target withBlock: (void (^)(id <_MACoordinateAdjacentConversion> nextTarget))block
{
    if([target MACoordinateAdjacentConversion_isView] && [(NSView *)target window] == self)
    {
        block(target);
    }
    else
    {
        block([_MACoordinateSystemScreen screen]);
        if(target != [_MACoordinateSystemScreen screen])
            [[_MACoordinateSystemScreen screen] MACoordinateAdjacentConversion_enumerateConversionChainTo: target withBlock: block];
    }
}

- (BOOL)MACoordinateAdjacentConversion_isView
{
    return NO;
}

- (BOOL)MACoordinateAdjacentConversion_isWindow
{
    return YES;
}

- (BOOL)MACoordinateAdjacentConversion_isScreen
{
    return NO;
}

@end

@implementation NSView (_MACoordinateAdjacentConversion)

- (NSRect)MACoordinateAdjacentConversion_convertRect: (NSRect)r to: (id <_MACoordinateAdjacentConversion>)target
{
    if([target MACoordinateAdjacentConversion_isView])
        return [self convertRect: r toView: (NSView *)target];
    else if([target MACoordinateAdjacentConversion_isWindow])
        return [self convertRect: r toView: nil];
    
    NSLog(@"Cannot convert directly from view %@ to target %@", self, target);
    abort();
}

- (void)MACoordinateAdjacentConversion_enumerateConversionChainTo: (id <_MACoordinateAdjacentConversion>)target withBlock: (void (^)(id <_MACoordinateAdjacentConversion> nextTarget))block
{
    if([target MACoordinateAdjacentConversion_isView] && [self ancestorSharedWithView: (NSView *)target])
    {
        block(target);
    }
    else
    {
        block([self window]);
        if(target != [self window])
            [[self window] MACoordinateAdjacentConversion_enumerateConversionChainTo: target withBlock: block];
    }
}

- (BOOL)MACoordinateAdjacentConversion_isView
{
    return YES;
}

- (BOOL)MACoordinateAdjacentConversion_isWindow
{
    return NO;
}

- (BOOL)MACoordinateAdjacentConversion_isScreen
{
    return NO;
}

@end

@implementation MACoordinateSystem {
    id <_MACoordinateAdjacentConversion> _underlyingTarget;
}

- (instancetype)initWithTarget: (id <_MACoordinateAdjacentConversion>)target
{
    if((self = [super init]))
    {
        _underlyingTarget = target;
    }
    return self;
}

- (instancetype)initWithScreenCoordinateSystem
{
    return [self initWithTarget: [_MACoordinateSystemScreen screen]];
}

- (instancetype)initWithWindow: (NSWindow *)window
{
    return [self initWithTarget: window];
}

- (instancetype)initWithView: (NSView *)view
{
    return [self initWithTarget: view];
}

- (NSRect)convertRect: (NSRect)r toCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    __block NSRect result = r;
    __block id <_MACoordinateAdjacentConversion> previousTarget = _underlyingTarget;
    [_underlyingTarget
     MACoordinateAdjacentConversion_enumerateConversionChainTo: coordinateSystem->_underlyingTarget
     withBlock: ^(id<_MACoordinateAdjacentConversion> nextTarget) {
         result = [previousTarget MACoordinateAdjacentConversion_convertRect: result to: nextTarget];
         previousTarget = nextTarget;
     }];
    return result;
}

- (NSPoint)convertPoint: (NSPoint)p toCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    return [self convertRect: (NSRect){ p, NSZeroSize } toCoordinateSystem: coordinateSystem].origin;
}

- (NSSize)convertSize: (NSSize)s toCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    return [self convertRect: (NSRect){ NSZeroPoint, s } toCoordinateSystem: coordinateSystem].size;

}

@end

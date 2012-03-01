//
//  MACoordinateSystem.m
//  NSRectangle
//
//  Created by Michael Ash on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MACoordinateSystem.h"

@implementation MACoordinateSystem {
    NSWindow *_window;
    NSView *_view;
}

- (instancetype)init
{
    return [super init];
}

- (instancetype)initWithScreenCoordinateSystem
{
    return [self init];
}

- (instancetype)initWithWindow: (NSWindow *)window
{
    if((self = [self init]))
    {
        _window = window;
    }
    return self;
}

- (instancetype)initWithView: (NSView *)view
{
    if((self = [self init]))
    {
        _view = view;
    }
    return self;
}

- (MACoordinateSystem *)_commonAncestorWith: (MACoordinateSystem *)coordinateSystem
{
    if(_view && [coordinateSystem view] && [_view ancestorSharedWithView: [coordinateSystem view]])
        return [[[self class] alloc] initWithWindow: [_view window]];
    
    return [[[self class] alloc] initWithScreenCoordinateSystem];
}

- (NSWindow *)window
{
    return _window;
}

- (NSView *)view
{
    return _view;
}

- (NSPoint)convertPoint: (NSPoint)p toCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    MACoordinateSystem *commonAncestor = [self _commonAncestorWith: coordinateSystem];
    
}

- (NSSize)convertSize: (NSSize)s toCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
}

@end

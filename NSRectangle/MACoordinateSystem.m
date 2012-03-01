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
    
    if(_view)
    {
        p = [_view convertPoint: p toView: nil];
        if(![commonAncestor window])
            p = [[_view window] convertRectToScreen: (NSRect){ p, NSZeroSize }].origin;
    }
    else if(_window)
    {
        if(![commonAncestor window])
            p = [[_view window] convertRectToScreen: (NSRect){ p, NSZeroSize }].origin;
    }
    
    if([coordinateSystem view])
    {
        if(![commonAncestor window])
            p = [[[coordinateSystem view] window] convertRectFromScreen: (NSRect){ p, NSZeroSize }].origin;
        p = [[coordinateSystem view] convertPoint: p fromView: nil];
    }
    else if([coordinateSystem window])
    {
        if(![commonAncestor window])
            p = [[[coordinateSystem view] window] convertRectFromScreen: (NSRect){ p, NSZeroSize }].origin;
    }
    
    return p;
}

- (NSSize)convertSize: (NSSize)s toCoordinateSystem: (MACoordinateSystem *)coordinateSystem
{
    MACoordinateSystem *commonAncestor = [self _commonAncestorWith: coordinateSystem];
    
    if(_view)
    {
        s = [_view convertSize: s toView: nil];
        if(![commonAncestor window])
            s = [[_view window] convertRectToScreen: (NSRect){ NSZeroPoint, s }].size;
    }
    else if(_window)
    {
        if(![commonAncestor window])
            s = [[_view window] convertRectToScreen: (NSRect){ NSZeroPoint, s }].size;
    }
    
    if([coordinateSystem view])
    {
        if(![commonAncestor window])
            s = [[[coordinateSystem view] window] convertRectFromScreen: (NSRect){ NSZeroPoint, s }].size;
        s = [[coordinateSystem view] convertSize: s fromView: nil];
    }
    else if([coordinateSystem window])
    {
        if(![commonAncestor window])
            s = [[[coordinateSystem view] window] convertRectFromScreen: (NSRect){ NSZeroPoint, s }].size;
    }
    
    return s;
}

@end

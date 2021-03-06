//
//  GeminiDisplayGroup.m
//  Gemini
//
//  Created by James Norton on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GemDisplayGroup.h"
#import "LGeminiDisplay.h"

@implementation GemDisplayGroup

@synthesize objects;

-(id)initWithLuaState:(lua_State *)luaState {
    self = [super initWithLuaState:luaState LuaKey:GEMINI_DISPLAY_GROUP_LUA_KEY];
    if (self) {
        objects = [[NSMutableArray alloc] initWithCapacity:1];
        
    }
    
    return self;
    
}

// this initializer is for objets that are from child classes of GemDisplayGroup (like GemLayer)
-(id)initWithLuaState:(lua_State *)luaState LuaKey:(const char *)luaKey {
    self = [super initWithLuaState:luaState LuaKey:luaKey];
    if (self) {
        objects = [[NSMutableArray alloc] initWithCapacity:1];
        
    }
    
    return self;
}

/*-(void)dealloc {
    [objects release];
    [super dealloc];
}*/

-(void)setLayer:(GemLayer *)_layer {
    layer = _layer;
    for (int i=0; i<[objects count]; i++) {
        GemDisplayObject *child = (GemDisplayObject *)[objects objectAtIndex:i];
        child.layer = layer;
    }
}

-(void)insert:(GemDisplayObject *)obj {
    [self insert:obj atIndex:[objects count]];
    
}

-(void)insert:(GemDisplayObject *)obj atIndex:(int)indx {
    //NSLog(@"Calling insert for GeminiDisplayGroup");
    
    [objects insertObject:obj atIndex:indx];
    [(GemDisplayGroup *)(obj.parent) remove:obj];
    obj.parent = self;
    GemLayer *parentLayer;
    if (self.layer == nil) {
        // this must be a layer
        parentLayer = (GemLayer *)self;
    } else {
        parentLayer = self.layer;
    }
    
    obj.layer = parentLayer;
}

-(void)remove:(GemDisplayObject *)obj {
    //NSLog(@"Calling remove for GeminiDisplayGroup");
    [objects removeObject:obj];
    obj.parent = nil;
}




-(unsigned int) numChildren {
    return [objects count];
}

// compute the height and width of this group based on the object within it
-(void)recomputeWidthHeight {
    
}

@end

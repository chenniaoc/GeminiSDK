//
//  GeminiSpriteSet.h
//  Gemini
//
//  Created by James Norton on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GemSpriteSheet.h"
#import "GemSpriteAnimation.h"

#define GEMINI_SPRITE_SET_LUA_KEY "GeminiLib.GEMINI_SPRITE_SET_LUA_KEY"
#define GEMINI_DEFAULT_ANIMATION @"default"

@interface GemSpriteSet : NSObject {
    GemSpriteSheet *spriteSheet;
    int startFrame;
    int frameCount;
    NSMutableDictionary *animations;
}

@property (readonly) GemSpriteSheet *spriteSheet;

-(id) initWithSpriteSheet:(GemSpriteSheet *)sheet StartFrame:(int)start NumFrames:(int)nFrames;

// Note - frames are numbered starting with 1, not 0, as per Lua convention
-(void) addAnimation:(NSString *)name WithStartFrame:(int)start NumFrames:(int)nFrames FrameDuration:(float)duration LoopCount:(int)loopCount;

-(GemSpriteAnimation *)getAnimation:(NSString *)animation;

@end

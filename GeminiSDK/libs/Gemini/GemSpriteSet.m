//
//  GeminiSpriteSet.m
//  Gemini
//
//  Created by James Norton on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GemSpriteSet.h"
#import "GemSpriteAnimation.h"

@implementation GemSpriteSet

@synthesize spriteSheet;

-(id) initWithSpriteSheet:(GemSpriteSheet *)sheet StartFrame:(int)start NumFrames:(int)nFrames {
    self = [super init];
    
    if (self) {
        startFrame = start;
        frameCount = nFrames;
        animations = [[NSMutableDictionary alloc] initWithCapacity:1];
        // add a default animation
        GemSpriteAnimation *animation = [[GemSpriteAnimation alloc] init];
        animation.startFrame = start;
        animation.frameCount = nFrames;
        animation.frameDuration = 0.1; // 10 frames per sec
        animation.loopCount = 0; // loop forever
        [animations setObject:animation forKey:GEMINI_DEFAULT_ANIMATION];
        spriteSheet = sheet;
    }
    
    return self;
}

// add an animation definition to the sprite set
// NOTE: the start parameter is wrt to the start frame of this sprite set, not the whole sprite sheet
-(void) addAnimation:(NSString *)name WithStartFrame:(int)start NumFrames:(int)nFrames FrameDuration:(float)duration LoopCount:(int)loopCount {
    GemSpriteAnimation *animation = [[GemSpriteAnimation alloc] init];
    animation.startFrame = startFrame + start - 1;
    animation.frameCount = nFrames;
    animation.frameDuration = duration;
    animation.loopCount = loopCount;
    [animations setObject:animation forKey:name];
}

-(GemSpriteAnimation *)getAnimation:(NSString *)animation {
    return (GemSpriteAnimation *)[animations objectForKey:animation];
}

@end

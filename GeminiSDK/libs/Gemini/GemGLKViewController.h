//
//  GeminiGLKViewController.h
//  Gemini
//
//  Created by James Norton on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "GemLineShaderManager.h"
#import "GemRenderer.h"
#import "GemSpriteManager.h"
#import "GemTimerManager.h"
#import "GemDirector.h"
#import "GemEventManager.h"
#import "GemParticleSystemManager.h"

// Uniform index.
enum {
    UNIFORM_PROJECTION,
    UNIFORM_ROTATION,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_TEXCOORD,
    NUM_ATTRIBUTES
};

typedef enum {
    GEM_IPHONE,
    GEM_IPHONE_RETINA,
    GEM_IPHONE_5,
    GEM_IPAD,
    GEM_IPAD_RETINA
    
} GemDisplayType;


@interface GemGLKViewController : GLKViewController {
    EAGLContext *context;
    SEL preRenderCallback;
    SEL postRenderCallback;
    GemShaderManager *lineShaderManager;
    GemSpriteManager *spriteManager;
    GemTimerManager *timerManager;
    GemDirector *director;
    GemEventManager *eventManager;
    GemParticleSystemManager *particleSystemManager;
    double updateTime;
}

@property (readonly) GemSpriteManager *spriteManager;
@property (readonly) GemTimerManager *timerManager;
@property (readonly) GemEventManager *eventManager;
@property (readonly) GemDirector *director;
@property (readonly) double updateTime;
@property (nonatomic) GemDisplayType displayType;
@property (readonly) GemParticleSystemManager *particleSystemManager;

-(void)setPreRenderCallback:(SEL)callback;
-(void)setPostRenderCallback:(SEL)callback;
-(id)initWithLuaState:(lua_State *)luaState;
@end

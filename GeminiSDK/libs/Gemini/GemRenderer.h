//
//  GeminiRenderer.h
//  Gemini
//
//  Created by James Norton on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GemDisplayGroup.h"
#import "GemLineShaderManager.h"
#import "GemSpriteShaderManager.h"
#import "GeminiRectangleShaderManager.h"
#include "GeminiTypes.h"
#import "GemScene.h"
#import "GemOpenGLState.h"

#define DEFAULT_STAGE_NAME @"DEFAULT_STAGE"
#define LINE_SHADER_PROGRAM_KEY @"LINE_SHADER_PROGRAM_KEY"
#define SPRITE_SHADER_PROGRAM_KEY @"SPRITE_SHADER_PROGRAM_KEY"

#define RECTANGLE_COUNT_LIMIT 256


@interface GemRenderer : NSObject {
    
    GemScene *activeScene;
    NSMutableDictionary *spriteBatches;
    NSMutableArray *physicsShapes;
    GLuint lineShaderProgram;
    GLuint spriteShaderProgram;
    GLuint vertexBuffer;
    GLuint colorBuffer;
    GLuint indexBuffer;
    GLuint lineVAO;
    GLuint rectangleVAO;
    GLuint spriteVAO;
    GemLineShaderManager *lineShaderManager;
    GemSpriteShaderManager *spriteShaderManager;
    GeminiRectangleShaderManager *rectangleShaderManager;
}

@property (readonly) GemSpriteShaderManager *spriteShaderManager;

-(id) initWithLuaState:(lua_State *)luaState;

-(void)renderScene:(GemScene *)scene;



@end

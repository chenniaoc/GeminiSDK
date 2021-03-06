//
//  GemDirector.h
//  GeminiSDK
//
//  Created by James Norton on 8/17/12.
//
//  This class manages GemScenes 
//

#import <Foundation/Foundation.h>
#import "GemScene.h"
#import "GemSceneTransition.h"
#import "GemRenderer.h"

#define GEM_DEFAULT_SCENE @"GEM_DEFAULT_SCENE"
#define GEM_DEFAULT_SCENE_DEFAULT_LAYER_INDEX 100


@interface GemDirector : GemObject {
    NSMutableDictionary *scenes;
    NSMutableArray *allScenes;
    NSString *currentScene;  // the current scene used for rendering, etc.
    NSMutableSet *loadingScenes;
    NSMutableDictionary *transitions;
    GemSceneTransition *currentTransition;
    GemRenderer *renderer;
}

@property (readonly) GemRenderer *renderer;

-(void)loadScene:(NSString *)sceneName;
-(void)gotoScene:(NSString *)scene withOptions:(NSDictionary *)options;
-(void)destroyScene:(NSString *)scene;
-(void)addScene:(GemScene *)scene;
-(GemScene *)getCurrentScene;
-(GemScene *)getDefaultScene;
-(void)setCurrentScene:(NSString *)scene;
-(void)render:(double)timeSinceLastRender;

@end

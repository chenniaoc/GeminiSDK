//
//  GemPhysics.h
//  GeminiSDK
//
//  Created by James Norton on 9/9/12.
//
//

#import <Foundation/Foundation.h>
#import "GemDisplayObject.h"

#define RENDER_PADDING (4.0)

typedef enum {
    GEM_PHYSICS_NORMAL,
    GEM_PHYSICS_HYBRID,
    GEM_PHYSICS_DEBUG
} GemPhysicsDrawMode;

typedef struct {
    double x;
    double y;
} GemPoint;

@interface GemPhysics : NSObject {
    double scale;
    GemPhysicsDrawMode drawMode;
   
}

-(void)setScale:(double)s;
-(float)getScale;
-(void)setDrawMode:(GemPhysicsDrawMode)mode;
-(void)setContinous:(bool) cont;
-(void)setGravityGx:(float)gx Gy:(float)gy;
-(void)pause;
-(void)start;
-(GemPoint)toPhysicsCoord:(GemPoint)point;
-(GemPoint)fromPhysicsCoord:(GemPoint)point;
-(void)addBodyForObject:(GemDisplayObject *)obj WithParams:(NSDictionary *)params;
-(void)update:(double)deltaT;
-(BOOL)doesBody:(void *)body ContainPoint:(GLKVector2)point;
-(bool)isActiveBody:(void *)body;
-(void)setBody:(void *)body isActive:(bool)active;

@end

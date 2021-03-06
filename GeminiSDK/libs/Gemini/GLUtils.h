//
//  GLUtils.h
//  GeminiSDK
//
//  Created by James Norton on 9/20/12.
//
//

#import <GLKit/GLKit.h>

#ifdef __cplusplus
extern "C" {
#endif

    void transformVertices(GLfloat *outVerts, GLfloat *inVerts, GLuint vertCount, GLKMatrix3 transform);
    GLKMatrix4 computeModelViewProjectionMatrix(BOOL adjustForLayout);
    GLKTextureInfo *createTexture(NSString * imgFileName);
    void GemCheckGLError(void);
    GLKVector2 getDimensionsFromSettings(BOOL adjustForLayout);
    GLKVector2 pointToScreenCoordinates(GLKVector2 point);
    GLKVector2 screenCoordToPoint(GLKVector2 coord);
    GLfloat widthToDeviceWidth(GLfloat w);
    GLfloat heightToDeviceHeight(GLfloat h);
    CGRect frameToDeviceFrame(CGRect frame);
float randNorm(void);

#ifdef __cplusplus
}
#endif
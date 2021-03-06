//
//  LGeminiLuaSupport.m
//  Gemini
//
//  Created by James Norton on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LGeminiLuaSupport.h"

NSLock *globalLuaLock;

// call a lua method that takes a display object as its parameter
void callLuaMethodForDisplayObject(lua_State *L, int methodRef, GemDisplayObject *obj){
    lua_rawgeti(L, LUA_REGISTRYINDEX, methodRef);
    lua_rawgeti(L, LUA_REGISTRYINDEX, obj.selfRef);
    lua_pcall(L, 1, 0, 0);
    // empty the stack
    lua_pop(L, lua_gettop(L));
}

void createMetatable(lua_State *L, const char *key, const struct luaL_Reg *funcs){
    luaL_newmetatable(L, key);    
    lua_pushvalue(L, -1); // duplicates the metatable
    luaL_setfuncs(L, funcs, 0);
}

// generic index method for userdata types
int genericIndex(lua_State *L){
    // first check the uservalue 
    lua_getuservalue( L, -2 );
    if(lua_isnil(L,-1)){
        // GemLog(@"user value for user data is nil");
    }
    lua_pushvalue( L, -2 );
    
    lua_rawget( L, -2 );
    if( lua_isnoneornil( L, -1 ) == 0 )
    {
        return 1;
    }
    
    lua_pop( L, 2 );
    
    // second check the metatable   
    lua_getmetatable( L, -2 );
    lua_pushvalue( L, -2 );
    lua_rawget( L, -2 );
    
    // nil or otherwise, we return here
    return 1;
    
}

// generic new index method for userdata types
int genericNewIndex(lua_State *L){
    
    lua_getuservalue( L, -3 );  // table attached is attached to objects via user value
    lua_pushvalue(L, -3);
    lua_pushvalue(L,-3);
    lua_rawset( L, -3 );
    
    return 0;
}

// generic indexing for GeminiDisplayObjects
int genericGeminiDisplayObjectIndex(lua_State *L, GemDisplayObject *obj){
    if (lua_isstring(L, -1)) {
        
        const char *key = lua_tostring(L, -1);
        if (strcmp("xReference", key) == 0) {
            
            GLfloat xRef = obj.xReference;
            lua_pushnumber(L, xRef);
            return 1;
        } else if (strcmp("yReference", key) == 0) {
            
            GLfloat yref = obj.yReference;
            lua_pushnumber(L, yref);
            return 1;
            
        } else if (strcmp("xOrigin", key) == 0) {
            
            GLfloat xOrig = obj.xOrigin;
            lua_pushnumber(L, xOrig);
            return 1;
        } else if (strcmp("yOrigin", key) == 0) {
            
            GLfloat yOrig = obj.yOrigin;
            lua_pushnumber(L, yOrig);
            return 1;
            
        } else if (strcmp("x", key) == 0) {
            
            GLfloat x = obj.x;
            lua_pushnumber(L, x);
            return 1;
            
        } else if (strcmp("y", key) == 0) {
            
            GLfloat y = obj.y;
            lua_pushnumber(L, y);
            return 1;
            
        } else if (strcmp("width", key) == 0){
            GLfloat width = obj.width;
            lua_pushnumber(L, width);
            return 1;
            
        } else if (strcmp("alpha", key) == 0){
            GLfloat alpha = obj.alpha;
            lua_pushnumber(L, alpha);
            return 1;
            
        } else if (strcmp("rotation", key) == 0) {
            
            GLfloat rot = obj.rotation;
            lua_pushnumber(L, rot);
            return 1;
            
        } else if (strcmp("name", key) == 0){
            NSString *name = obj.name;
            lua_pushstring(L, [name UTF8String]);
            return 1;
        } else if (strcmp("isVisible", key) == 0){
            bool visible = obj.isVisible;
            lua_pushboolean(L, visible);
            return 1;
        } else if (strcmp("isActive", key) == 0) {
            bool isActive = [obj isActive];
            lua_pushboolean(L, isActive);
            return 1;
        } else if (strcmp("isFlippedHorizontally", key) == 0){
            bool flipped = obj.isFlippedHorizontally;
            lua_pushboolean(L, flipped);
            return 1;
        } else if (strcmp("isFlippedVertically", key) == 0){
            bool flipped = obj.isFlippedVertically;
            lua_pushboolean(L, flipped);
            return 1;
        } else if (strcmp("fixedRotation", key) == 0){
            bool fixed = obj.fixedRotation;
            lua_pushboolean(L, fixed);
            return 1;
        } else if (strcmp("vx", key) == 0){
            GLKVector2 vel = obj.linearVelocity;
            lua_pushnumber(L, vel.x);
            
            return 1;
        } else if (strcmp("vy", key) == 0){
            GLKVector2 vel = obj.linearVelocity;
            lua_pushnumber(L, vel.y);
            
            return 1;
        } else {
            return genericIndex(L);
        }
        
    }
    
    return 0;
    
}


// generic new index method for userdata types
int genericGemDisplayObjecNewIndex(lua_State *L, GemDisplayObject __unsafe_unretained **obj){
    
    if (lua_isstring(L, 2)) {
        
        if (obj != NULL) {
            const char *key = lua_tostring(L, 2);
            if (strcmp("xReference", key) == 0) {
                
                GLfloat xref = luaL_checknumber(L, 3);
                [*obj setXReference:xref];
                return 0;
                
            } else if (strcmp("yReference", key) == 0) {
                
                GLfloat yref = luaL_checknumber(L, 3);
                [*obj setYReference:yref];
                return 0;
                
            } else if (strcmp("x", key) == 0) {
                
                GLfloat x = luaL_checknumber(L, 3);
                [*obj setX:x];
                return 0;
                
            } else if (strcmp("y", key) == 0) {
                
                GLfloat y = luaL_checknumber(L, 3);
                [*obj setY:y];
                if ((*obj).physicsBody) {
                    // if this is a physics object then change the physics body too
                    GLKVector3 trans = GLKVector3Make((*obj).x, y, (*obj).rotation);
                    [*obj setPhysicsTransform:trans];
                }
                return 0;
                
            } else if (strcmp("xOrigin", key) == 0) {
                
                GLfloat xOrigin = luaL_checknumber(L, 3);
                [*obj setXOrigin:xOrigin];
                return 0;
                
            } else if (strcmp("yOrigin", key) == 0) {
                
                GLfloat yOrigin = luaL_checknumber(L, 3);
                [*obj setYOrigin:yOrigin];
                return 0;
                
            } else if (strcmp("rotation", key) == 0) {
                
                GLfloat rot = luaL_checknumber(L, 3);
                [*obj setRotation:rot];
                return 0;
                
            } else if (strcmp("xScale", key) == 0){
                GLfloat xScale = luaL_checknumber(L, 3);
                [*obj setXScale:xScale];
                
                return 0;
                
            } else if (strcmp("yScale", key) == 0){
                GLfloat yScale = luaL_checknumber(L, 3);
                [*obj setYScale:yScale];
                return 0;
                
            } else if (strcmp("width", key) == 0){
                GLfloat width = luaL_checknumber(L, 3);
                [*obj setWidth:width];
                return 0;
                
            } else if (strcmp("alpha", key) == 0){
                GLfloat alpha = luaL_checknumber(L, 3);
                [*obj setAlpha:alpha];
                return 0;
                
            } else if (strcmp("name", key) == 0){
                
                const char *valCStr = lua_tostring(L, 3);
                //GemLog(@"Setting object name to %s", valCStr);
                (*obj).name = [NSString stringWithUTF8String:valCStr];
            } else if (strcmp("isVisible", key) == 0){
                BOOL visible = lua_toboolean(L, 3);
                [*obj setIsVisible:visible];
                return 0;
            } else if (strcmp("isActive", key) == 0){
                bool active = lua_toboolean(L, 3);
                [*obj setIsActive:active];
                return 0;
            } else if (strcmp("isFlippedHorizontally", key) == 0){
                bool flipped = lua_toboolean(L, 3);
                (*obj).isFlippedHorizontally = flipped;
                return 0;
            } else if (strcmp("isFlippedVertically", key) == 0){
                bool flipped = lua_toboolean(L, 3);
                (*obj).isFlippedVertically = flipped;
                return 0;
            } else if (strcmp("fixedRotation", key) == 0){
                bool fixed = lua_toboolean(L, 3);
                (*obj).fixedRotation = fixed;
                return 0;
            } else {
                return genericNewIndex(L);
            }
        }
        
        // defualt to storing value in attached lua table
        return genericNewIndex(L);
        
    } 
    
    
    
    return 0;
    
}

int isObjectTouching(lua_State *L){
    __unsafe_unretained GemDisplayObject **displayObjA = (__unsafe_unretained GemDisplayObject **)lua_touserdata(L, 1);
    __unsafe_unretained GemDisplayObject **displayObjB = (__unsafe_unretained GemDisplayObject **)lua_touserdata(L, 2);
    
    bool isTouching = false;
    
    NSArray *touching = [*displayObjA getTouchingObjects];
    GemLog(@"touching %d objects", [touching count]);
    if ([touching containsObject:*displayObjB]) {
        isTouching = true;
    }
    
    lua_pushboolean(L, isTouching);
    
    return 1;
    
    
}

int removeSelf(lua_State *L){
    __unsafe_unretained GemDisplayObject **displayObj = (__unsafe_unretained GemDisplayObject **)lua_touserdata(L, -1);
    [(*displayObj).parent remove:*displayObj];
    
    return 0;
}

int genericDelete(lua_State *L){
    __unsafe_unretained GemDisplayObject  **obj = (__unsafe_unretained GemDisplayObject **)lua_touserdata(L, -1);
    GemLog(@"LGeminiSupport: deleting display object %@", (*obj).name);
    
    [(*obj).parent remove:*obj];
    
    return 0;
}


// this method is only here to allow checks to see if Lua is properly GC'ing objects
// it doesn't actually do anything - all the action is in the various delete methods
int genericGC (lua_State *L){
    //GemRectangle  **rect = (GemRectangle **)luaL_checkudata(L, 1, GEMINI_RECTANGLE_LUA_KEY);
    
    GemLog(@"GARBAGE COLLECTED => LGeminiSupport: GC called for dipslay object");
    
    
    return 0;
}

// used to set common defaults for all display objects
// this function expects a table to be the top item on the stack
void setDefaultValues(lua_State *L) {
    assert(lua_type(L, -1) == LUA_TTABLE);
    lua_pushstring(L, "x");
    lua_pushnumber(L, 0);
    lua_settable(L, -3);
    
    lua_pushstring(L, "y");
    lua_pushnumber(L, 0);
    lua_settable(L, -3);
    
    lua_pushstring(L, "xOrigin");
    lua_pushnumber(L, 0);
    lua_settable(L, -3);
    
    lua_pushstring(L, "yOrigin");
    lua_pushnumber(L, 0);
    lua_settable(L, -3);
    
    lua_pushstring(L, "xReference");
    lua_pushnumber(L, 0);
    lua_settable(L, -3);
    
    lua_pushstring(L, "yReference");
    lua_pushnumber(L, 0);
    lua_settable(L, -3);
    
}

// generic init method
void setupObject(lua_State *L, const char *luaKey, GemObject *obj){
    
    luaL_getmetatable(L, luaKey);
    lua_setmetatable(L, -2);
    
    // append a lua table to this user data to allow the user to store values in it
    lua_newtable(L);
    lua_pushvalue(L, -1); // make a copy of the table becaue the next line pops the top value
    // store a reference to this table so our object methods can access it
    obj.propertyTableRef = luaL_ref(L, LUA_REGISTRYINDEX);
    
    // add in some default values for display objects
    if ([obj isKindOfClass:[GemDisplayObject class]]) {
        setDefaultValues(L);
    }
    
    // set the table as the user value for the Lua object
    lua_setuservalue(L, -2);
    
    // create a table for the event listeners
    lua_newtable(L);
    obj.eventListenerTableRef = luaL_ref(L, LUA_REGISTRYINDEX);
    
    lua_pushvalue(L, -1); // make another copy of the userdata since the next line will pop it off
    obj.selfRef = luaL_ref(L, LUA_REGISTRYINDEX);
}

NSDictionary *tableToDictionary(lua_State *L, int stackIndex){
    NSMutableDictionary *rval = [NSMutableDictionary dictionaryWithCapacity:1];
    
    // handle negative indices correctly since pushing nil as the first key will
    // invalidate them
    if (stackIndex < 1) {
        stackIndex = lua_gettop(L) + stackIndex + 1;
    }
    
    if (lua_istable(L, stackIndex)) {
        lua_pushnil(L);  /* first key */
        while (lua_next(L, stackIndex) != 0) {
            /* uses 'key' (at index -2) and 'value' (at index -1) */
            id key;
            id value;
            switch (lua_type(L, -2)) {
                case LUA_TNUMBER:
                    key = [NSNumber numberWithDouble:lua_tonumber(L, -2)];
                    break;
                case LUA_TSTRING:
                    key = [NSString stringWithUTF8String:lua_tostring(L, -2)];
                    break;
                default:
                    break;
            }
            
            //GemLog(@"table key = %@", key);
            
            switch (lua_type(L, -1)) {
                case LUA_TNUMBER:
                    value = [NSNumber numberWithDouble:lua_tonumber(L, -1)];
                    break;
                case LUA_TSTRING:
                    value = [NSString stringWithUTF8String:lua_tostring(L, -1)];
                    break;
                case LUA_TBOOLEAN:
                    value = [NSNumber numberWithBool:lua_toboolean(L, -1)];
                    break;
                case LUA_TTABLE:
                    value = tableToDictionary(L, -1);
                    break;
                default:
                    break;
            }
            
            //GemLog(@"table value = %@", value);
            
            if (key != nil) {
                [rval setObject:value forKey:key];
            }
            
            /* removes 'value'; keeps 'key' for next iteration */
            lua_pop(L, 1);
        }
    }
    
    return rval;

}

// mutex for Lua
void lockLuaLock(){
    if (globalLuaLock == nil){
        globalLuaLock = [[NSLock alloc] init];
    }
    
    [globalLuaLock lock];
    
}

void unlockLuaLock(){
    [globalLuaLock unlock];
}

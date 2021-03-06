//
//  LGeminiDisplay.h
//  Gemini
//
//  Created by James Norton on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#import "GemLayer.h"

#define GEMINI_DISPLAY_LUA_KEY "GeminiLib.GEMINI_DISPLAY_LUA_KEY"


int luaopen_display_lib (lua_State *L);

GemLayer *createLayerZero(lua_State *L);
## What is Gemini?

Gemini is an open source framework for building 2D games on iOS using the [Lua](http://www.lua.org) scripting language.

1. **Gemini uses a layer based** rendering system.  Each layer can have any blending mode (including no blending) supported by OpenGL:  additive blending, alpha blending, you name it.
2. **Gemini provides high level graphics objects** including sprites, sprite sheets, and geometric primitives like poly-lines and rectangles.  All rendering is done in high performance OpenGL ES 2.0 code using sprite batching and other optimizations for maximum efficiency.
3. **Gemini provides scene management**.  Script each level of your game as  a separate Lua module and control the order in which they get loaded directly in your Lua code via the _Director_ API.  Use built in scene transitions or code your own.
4. **Gemini provides physics**.  Bindings to the [Box2D](http://box2d.org) physics library allow you to add physics properties to any graphics object, including support for collision detection.
5. **Gemini does sound**.  Bindings to the [Object AL](http://kstenerud.github.com/ObjectAL-for-iPhone/) sound API provide easy sound effects and background music.
6. **Gemini provides an event API**.  Register objects for touch events, collision events, or other events.  Set up timer events (one-shot or recurring) to call your Lua code periodically.  Regiser Lua code as callbacks for events like the beginning of the render loop.
7. **Gemini supports popular third party tools.** Import sprites sheets created in [Sprite Helper](http://www.spritehelper.org) or [Texture Packer](http://www.codeandweb.com/texturepacker).  Render text using font files created with [Glyph Designer](http://glyphdesigner.71squared.com).
8. **Gemini supports callbacks to custom Objective C/C++ code**.  Use render callbacks to render layers with your own custom Objective C/C++ code.
9. **It's easy to get started.** Just drop the Xcode 4 project templates in your template folder and you're ready to go.

## Installation

The zip file containing the templates can be found [here](https://s3.amazonaws.com/GeminiSDK_Templates/xcode4_templates.zip).  This file has been signed with OpenPGP and the signature file is [here](https://s3.amazonaws.com/GeminiSDK_Templates/xcode4_templates.zip.sig).  After validating the zip file, uncompress it and copy the contents into ~/Library/Developer/Xcode/Templates/Gemini/ then restart Xcode.  You should now be able to choose a Gemini project when you choose File->New->Project in Xcode.

## Documentation

Check out the [project page](http://indiejames.github.com/GeminiSDK) or go directly to the [Lua API docs](http://indiejames.github.com/GeminiSDK/documentation/index.html).  Also check out the [Wiki](https://github.com/indiejames/GeminiSDK/wiki/Documentation) for guides and examples.


## Contributing

Contributions to Gemini are welcome, whether it's a bug report, feature suggestion, or a pull request.  Gemini is very much a work in progress and I am focusing on core features first to get it production ready as soon as possible.

## License
(The MIT License)

Copyright (c) 2012-2013 James Norton

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#### If you want to be awesome.
- Credit Gemini in any apps you build with it.
- Add your app to the [app list](https://github.com/indiejames/GeminiSDK/wiki/List-of-Apps-Using-Gemini) in the Wiki so we can watch the community grow.
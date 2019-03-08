# AboutWindowFramework
Swift clone of PFAboutWindow

### PFAboutWindow
[PFAboutWindow](https://github.com/perfaram/PFAboutWindow) is a Objective-C-Only library which provides a pretty designed About-Window for your application. Is is super easy to show credits, eula and copyright information in a great looking window which is oriented on Xcode6's About-Window design.

### Purpose
Since there was no Swift version of this library I thought I'd convert it by myself. You can find a Swift clone of PFAboutWindow in this repository. Also the .xib file was migrated to use AutoLayout. Everything is supported except for localizing the Buttons. If you need to localize the buttons you have to add it by yourself by creating a Localizable.strings file. Feel free to add it on your own and create a pull request !

### Version
1.5.7

### Screenshots
Before you download/install the application you can get a little sneak peek by looking at this screenshots:

![alt tag](https://raw.github.com/dehlen/AboutWindowController/master/screenshot1.png)

![alt tag](https://raw.github.com/dehlen/AboutWindowController/master/screenshot2.png)

### Installation/Usage

This library can be installed via Carthage:

```
github "dehlen/AboutWindowController"
```

Then just add it to your project like so:

```swift
import AboutWindowFramework

lazy var aboutWindowControllerConfig: AboutWindowControllerConfig = {
    let website = URL(string: "https://github.com/T-Rex-Editor")
   
    return AboutWindowControllerConfig(name: "App Name", version: nil, copyright: nil, credits: nil, creditsButtonTitle: "Credits", eula: nil, eulaButtonTitle: "EULA", url: website, hasShadow: true)
}()

lazy var aboutWindowController: AboutWindowController = {
    return AboutWindowController.create(with: aboutWindowControllerConfig)
}()

@IBAction func showAboutWindow(_ sender:AnyObject) {
    aboutWindowController.showWindow(self)
}

```

Next connect the IBAction `showAboutWindow` with the About menu entry or some button you want.

### Development

Want to contribute? Great!
You might want to check out the open issues or fork this repository to create a pull request.

### Todo's
- None yet, If you have a Todo please create an issue

### License
----

The MIT License (MIT)

Copyright (c) 2019 David Ehlen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

**Free Software, Hell Yeah!**

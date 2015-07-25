//
//  AppDelegate.swift
//  TRexAboutWindowController
//
//  Created by David Ehlen on 25.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var aboutWindowController:TRexAboutWindowController
    
    override init() {
        self.aboutWindowController = TRexAboutWindowController(windowNibName: "PFAboutWindow")
        super.init()
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func showAboutWindow(sender:AnyObject) {
        self.aboutWindowController.appURL = NSURL(string:"https://github.com/T-Rex-Editor/")!
        self.aboutWindowController.appName = "TRex-Editor"
        let font:NSFont? = NSFont(name: "HelveticaNeue", size: 11.0)
        let color:NSColor? = NSColor.tertiaryLabelColor()
        let attribs:[String:AnyObject] = [NSForegroundColorAttributeName:color!,
            NSFontAttributeName:font!]
        
        
        self.aboutWindowController.appCopyright = NSAttributedString(string: "Copyright (c) 2015 David Ehlen", attributes: attribs)
        
        self.aboutWindowController.windowShouldHaveShadow = true
        self.aboutWindowController .showWindow(nil)
    }
}


//
//  TRexAboutWindowController.swift
//  T-Rex
//
//  Created by David Ehlen on 24.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Cocoa

public class TRexAboutWindowController : NSWindowController {
    public var appName : String = ""
    public var appVersion : String = ""
    public var appCopyright : NSAttributedString
    public var appCredits : NSAttributedString
    public var appEULA : NSAttributedString
    public var appURL : NSURL
    public var textShown : NSAttributedString
    public var windowState : Int = 0
    public var windowShouldHaveShadow: Bool = true
    
    @IBOutlet var infoView: NSView!
    @IBOutlet var textField: NSTextView!
    @IBOutlet var visitWebsiteButton: NSButton!
    @IBOutlet var EULAButton: NSButton!
    @IBOutlet var creditsButton: NSButton!
    @IBOutlet var versionLabel: NSTextField!
    
    override init(window: NSWindow?) {
        self.appCopyright = NSAttributedString()
        self.appCredits = NSAttributedString()
        self.appEULA = NSAttributedString()
        self.appURL = NSURL()
        self.textShown = NSAttributedString()
        
        super.init(window: window)
    }
    
    required public init?(coder: NSCoder) {
        self.appCopyright = NSAttributedString()
        self.appCredits = NSAttributedString()
        self.appEULA = NSAttributedString()
        self.appURL = NSURL()
        self.textShown = NSAttributedString()
        
        super.init(coder: coder)
    }
    
    override public func windowDidLoad() {
        super.windowDidLoad()
        self.windowState = 0
        self.infoView.wantsLayer = true
        self.infoView.layer!.cornerRadius = 10.0
        self.infoView.layer!.backgroundColor = NSColor.whiteColor().CGColor
        self.window?.backgroundColor = NSColor.whiteColor()
        self.window?.hasShadow = self.windowShouldHaveShadow
        
        if self.appName.characters.count <= 0 {
            self.appName = valueFromInfoDict("CFBundleName")
        }
        
        if self.appVersion.characters.count <= 0 {
            let version = valueFromInfoDict("CFBundleVersion")
            let shortVersion = valueFromInfoDict("CFBundleShortVersionString")
            self.appVersion = "Version \(shortVersion) (Build \(version))"
            versionLabel.stringValue = self.appVersion
        }
        
        if self.appCopyright.string.characters.count <= 0 {
            if floor(NSAppKitVersionNumber) <= Double(NSAppKitVersionNumber10_9) {
                let font:NSFont? = NSFont(name: "HelveticaNeue", size: 11.0)
                let color:NSColor? = NSColor.lightGrayColor()
                let attribs:[String:AnyObject] = [NSForegroundColorAttributeName:color!,
                                                  NSFontAttributeName:font!]
                self.appCopyright = NSAttributedString(string: valueFromInfoDict("NSHumanReadableCopyright"), attributes:attribs)
            }
            else {
                let font:NSFont? = NSFont(name: "HelveticaNeue", size: 11.0)
                let color:NSColor? = NSColor.tertiaryLabelColor()
                let attribs:[String:AnyObject] = [NSForegroundColorAttributeName:color!,
                                                  NSFontAttributeName:font!]
                self.appCopyright = NSAttributedString(string: valueFromInfoDict("NSHumanReadableCopyright"), attributes:attribs)
            }
        }
        
        if self.appCredits.string.characters.count <= 0 {
            if let creditsRTF = NSBundle.mainBundle().pathForResource("Credits", ofType: "rtf") {
                self.appCredits = NSAttributedString(path: creditsRTF, documentAttributes: nil)!
            }
            else {
                self.creditsButton.hidden = true
                print("Credits not found in bundle. Hiding Credits Button.")
            }
        }
        
        if self.appEULA.string.characters.count <= 0 {
            if let eulaRTF = NSBundle.mainBundle().pathForResource("EULA", ofType: "rtf") {
                self.appEULA = NSAttributedString(path: eulaRTF, documentAttributes: nil)!
            }
            else {
                self.EULAButton.hidden = true
                print("EULA not found in bundle. Hiding EULA Button.")
            }
        }
        
        self.textField.textStorage!.setAttributedString(self.appCopyright)
        self.creditsButton.title = "Credits"
        self.EULAButton.title = "EULA"
    }
    
    @IBAction func visitWebsite(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(self.appURL)
    }
    
    @IBAction func showCredits(sender: AnyObject) {
        if self.windowState != 1 {
            let amountToIncreaseHeight:CGFloat  = 100
            var oldFrame:NSRect = self.window!.frame
            oldFrame.size.height += amountToIncreaseHeight
            oldFrame.origin.y -= amountToIncreaseHeight
            self.window!.setFrame(oldFrame,display:true, animate:true)
            self.windowState = 1
        }
        self.textField.textStorage!.setAttributedString(self.appCredits)
    }
    
    @IBAction func showEULA(sender: AnyObject) {
        if self.windowState != 1 {
            let amountToIncreaseHeight:CGFloat  = 100
            var oldFrame:NSRect = self.window!.frame
            oldFrame.size.height += amountToIncreaseHeight
            oldFrame.origin.y -= amountToIncreaseHeight
            self.window!.setFrame(oldFrame,display:true, animate:true)
            self.windowState = 1
        }
        self.textField.textStorage!.setAttributedString(self.appEULA)
    }
    
    @IBAction func showCopyright(sender: AnyObject) {
        if self.windowState != 0 {
            let amountToIncreaseHeight:CGFloat  = -100
            var oldFrame:NSRect = self.window!.frame
            oldFrame.size.height += amountToIncreaseHeight
            oldFrame.origin.y -= amountToIncreaseHeight
            self.window!.setFrame(oldFrame,display:true, animate:true)
            self.windowState = 0
        }
        
        self.textField.textStorage!.setAttributedString(self.appCopyright)
    }
    
    public func windowShouldClose(sender: AnyObject) -> Bool {
        self.showCopyright(sender)
        return true
    }
    
    override public func showWindow(sender: AnyObject?) {
        super.showWindow(sender)
    }
    
    //Private
    private func valueFromInfoDict(string:String) -> String {
        let dictionary = NSBundle.mainBundle().infoDictionary!
        let result = dictionary[string] as! String
        return result
    }
}

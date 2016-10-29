//
//  TRexAboutWindowController.swift
//  T-Rex
//
//  Created by David Ehlen on 24.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Cocoa

open class TRexAboutWindowController : NSWindowController {
    open var appName : String = ""
    open var appVersion : String = ""
    open var appCopyright : NSAttributedString
    open var appCredits : NSAttributedString
    open var appEULA : NSAttributedString
    open var appURL : URL?
    open var textShown : NSAttributedString
    open var windowState : Int = 0
    open var windowShouldHaveShadow: Bool = true
    
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
        
        self.textShown = NSAttributedString()
        
        super.init(window: window)
    }
    
    required public init?(coder: NSCoder) {
        self.appCopyright = NSAttributedString()
        self.appCredits = NSAttributedString()
        self.appEULA = NSAttributedString()
        
        self.textShown = NSAttributedString()
        
        super.init(coder: coder)
    }
    
    override open func windowDidLoad() {
        super.windowDidLoad()
        self.windowState = 0
        self.infoView.wantsLayer = true
        self.infoView.layer!.cornerRadius = 10.0
        self.infoView.layer!.backgroundColor = NSColor.white.cgColor
        self.window?.backgroundColor = NSColor.white
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
                let color:NSColor? = NSColor.lightGray
                let attribs:[String:AnyObject] = [NSForegroundColorAttributeName:color!,
                                                  NSFontAttributeName:font!]
                self.appCopyright = NSAttributedString(string: valueFromInfoDict("NSHumanReadableCopyright"), attributes:attribs)
            }
            else {
                let font:NSFont? = NSFont(name: "HelveticaNeue", size: 11.0)
                let color:NSColor? = NSColor.tertiaryLabelColor
                let attribs:[String:AnyObject] = [NSForegroundColorAttributeName:color!,
                                                  NSFontAttributeName:font!]
                self.appCopyright = NSAttributedString(string: valueFromInfoDict("NSHumanReadableCopyright"), attributes:attribs)
            }
        }
        
        if self.appCredits.string.characters.count <= 0 {
            if let creditsRTF = Bundle.main.path(forResource: "Credits", ofType: "rtf") {
                self.appCredits = NSAttributedString(path: creditsRTF, documentAttributes: nil)!
            }
            else {
                self.creditsButton.isHidden = true
                print("Credits not found in bundle. Hiding Credits Button.")
            }
        }
        
        if self.appEULA.string.characters.count <= 0 {
            if let eulaRTF = Bundle.main.path(forResource: "EULA", ofType: "rtf") {
                self.appEULA = NSAttributedString(path: eulaRTF, documentAttributes: nil)!
            }
            else {
                self.EULAButton.isHidden = true
                print("EULA not found in bundle. Hiding EULA Button.")
            }
        }
        
        self.textField.textStorage!.setAttributedString(self.appCopyright)
        self.creditsButton.title = "Credits"
        self.EULAButton.title = "EULA"
    }
    
    @IBAction func visitWebsite(_ sender: AnyObject) {
        guard let url = self.appURL else { return }
        
        NSWorkspace.shared().open(url)
    }
    
    @IBAction func showCredits(_ sender: AnyObject) {
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
    
    @IBAction func showEULA(_ sender: AnyObject) {
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
    
    @IBAction func showCopyright(_ sender: AnyObject) {
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
    
    open func windowShouldClose(_ sender: AnyObject) -> Bool {
        self.showCopyright(sender)
        return true
    }
    
    override open func showWindow(_ sender: Any?) {
        super.showWindow(sender)
    }
    
    //Private
    fileprivate func valueFromInfoDict(_ string:String) -> String {
        let dictionary = Bundle.main.infoDictionary!
        let result = dictionary[string] as! String
        return result
    }
}

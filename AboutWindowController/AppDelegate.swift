import Cocoa
import AboutWindowFramework

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var aboutWindowControllerConfig: AboutWindowControllerConfig = {
        let website = URL(string: "https://github.com/T-Rex-Editor")
       
        return AboutWindowControllerConfig(name: "App Name", version: nil, copyright: nil, credits: nil, creditsButtonTitle: "Credits", eula: nil, eulaButtonTitle: "EULA", url: website, hasShadow: true)
    }()
    
    lazy var aboutWindowController: AboutWindowController = {
        return AboutWindowController.create(with: aboutWindowControllerConfig)
    }()
    
    func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool {
        return true
    }
    
    @IBAction func showAboutWindow(_ sender:AnyObject) {
        aboutWindowController.showWindow(self)
    }
}


import Cocoa

public class AboutWindowController: NSWindowController {
    private var windowState: AboutWindowControllerState = .collapsed
    private var config: AboutWindowControllerConfig = AboutWindowControllerConfig()

    @IBOutlet private var textField: NSTextView!
    @IBOutlet private var appNameLabel: NSTextField!
    @IBOutlet private var versionLabel: NSTextField!
    @IBOutlet private var creditsButton: NSButton!
    @IBOutlet private var eulaButton: NSButton!

    public static func create(with config: AboutWindowControllerConfig) -> AboutWindowController {
        let aboutWindowController = AboutWindowController(windowNibName: NSNib.Name("PFAboutWindow"))
        aboutWindowController.config = config
        return aboutWindowController
    }
    
    override open func windowDidLoad() {
        super.windowDidLoad()
        applyConfig()
    }
    
    private func applyConfig() {
        appNameLabel.stringValue = config.name
        versionLabel.stringValue = config.version
        textField.textStorage?.setAttributedString(config.copyright)
        creditsButton.title = config.creditsButtonTitle
        eulaButton.title = config.eulaButtonTitle
        window?.hasShadow = config.hasShadow
    }
    
    private func changeWindowState() {
        guard let window = window else { return }
        
        var frame = window.frame
        frame.size.height += windowState.yDiff
        frame.origin.y -= windowState.yDiff
        window.setFrame(frame, display: true, animate: true)
        
        windowState = windowState.toggle()
    }
    
    @IBAction private func visitWebsite(_ sender: AnyObject) {
        guard let url = config.url else { return }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction private func showCredits(_ sender: AnyObject) {
        if case .collapsed = windowState {
            changeWindowState()
        }

        textField.textStorage?.setAttributedString(config.credits)
    }
    
    @IBAction private func showEULA(_ sender: AnyObject) {
        if case .collapsed = windowState {
            changeWindowState()
        }

        textField.textStorage?.setAttributedString(config.eula)
    }
}

import Cocoa

public struct AboutWindowControllerConfig {
    private(set) var name: String = ""
    private(set) var version: String = ""
    private(set) var copyright: NSAttributedString = NSAttributedString()
    private(set) var credits: NSAttributedString = NSAttributedString()
    private(set) var creditsButtonTitle: String = "Acknowledgments"
    private(set) var eula: NSAttributedString = NSAttributedString()
    private(set) var eulaButtonTitle: String = "License Agreement"
    private(set) var url: URL? = nil
    private(set) var hasShadow: Bool = true
    
    private var appName: String {
        return Bundle.main.appName ?? ""
    }
    
    private var appVersion: String {
        let version = Bundle.main.buildVersionNumber ?? ""
        let shortVersion = Bundle.main.releaseVersionNumber ?? ""
        return "Version \(shortVersion) (Build \(version))"
    }
    
    private var appCopyright: String {
        return Bundle.main.copyright ?? ""
    }
    
    private var appCredits: NSAttributedString {
        let bundle = Bundle(for: AboutWindowController.self)
        guard let creditsRtf = bundle.url(forResource: "Credits", withExtension: "rtf") else {
            return NSAttributedString(string: "")
        }
        
        guard let attributedAppCredits = try? NSMutableAttributedString(url: creditsRtf, options: [:], documentAttributes: nil) else {
            return NSAttributedString(string: "")
        }
        
        let color = NSColor.textColor
        attributedAppCredits.apply(color: color)
        
        return attributedAppCredits
    }
    
    private var appEula: NSAttributedString {
        let bundle = Bundle(for: AboutWindowController.self)

        guard let eulaRtf = bundle.url(forResource: "EULA", withExtension: "rtf") else {
            return NSAttributedString(string: "")
        }
        
        guard let attributedAppEula = try? NSMutableAttributedString(url: eulaRtf, options: [:], documentAttributes: nil) else {
            return NSAttributedString(string: "")
        }
        
        let color = NSColor.textColor
        attributedAppEula.apply(color: color)
        
        return attributedAppEula
    }
    
    public init(name: String? = nil, version: String? = nil, copyright: NSAttributedString? = nil, credits: NSAttributedString? = nil, creditsButtonTitle: String = "Acknowledgments", eula: NSAttributedString? = nil, eulaButtonTitle: String = "License Agreement", url: URL? = nil, hasShadow: Bool = true) {
        self.name = name ?? appName
        self.version = version ?? appVersion
        self.copyright = copyright ?? AttributedStringHandler.copyright(with: appCopyright)
        self.credits = credits ?? appCredits
        self.creditsButtonTitle = creditsButtonTitle
        self.eula = eula ?? appEula
        self.eulaButtonTitle = eulaButtonTitle
        self.url = url
        self.hasShadow = hasShadow
    }
}

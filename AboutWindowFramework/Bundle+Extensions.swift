import Foundation

public extension Bundle {
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var appName: String? {
        return infoDictionary?[kCFBundleNameKey as String] as? String
    }
    
    public var copyright: String? {
        return infoDictionary?["NSHumanReadableCopyright"] as? String
    }
}


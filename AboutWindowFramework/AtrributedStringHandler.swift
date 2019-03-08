import Cocoa

public struct AttributedStringHandler {
    public static func copyright(with string: String) -> NSAttributedString {
        let font = NSFont.systemFont(ofSize: 10, weight: .ultraLight)
        let color = NSColor.secondaryLabelColor

        let copyright = NSMutableAttributedString(string: string)
        copyright.apply(font: font)
        copyright.apply(color: color)
        
        return copyright
    }
}

public extension NSMutableAttributedString {
    public func apply(color: NSColor) {
        let attributes: [NSAttributedString.Key: AnyObject] = [.foregroundColor : color]
        addAttributes(attributes, range: NSMakeRange(0, length))
    }
    
    public func apply(font: NSFont) {
        let attributes: [NSAttributedString.Key: AnyObject] = [.font : font]
        addAttributes(attributes, range: NSMakeRange(0, length))
    }
}

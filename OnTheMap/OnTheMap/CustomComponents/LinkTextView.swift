import Foundation
import UIKit

@IBDesignable public class LinkTextView : UITextView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeBaseStyles()
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initializeBaseStyles()
    }
    
    public override func prepareForInterfaceBuilder() {
        initializeBaseStyles()
    }

    public func stylizeLinks(font: UIFont = UIFont.systemFont(ofSize: 16), text: String, links: [String: String]) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attributeStyle =  [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let string = NSMutableAttributedString(string: text, attributes: attributeStyle)

        for (link, url) in links {
            if let validUrl = NSURL(string: url) {
                let foundRange = string.mutableString.range(of: link)
                string.setAttributes([NSAttributedString.Key.link : validUrl,
                NSAttributedString.Key.font : font,
                NSAttributedString.Key.foregroundColor: UIColor.systemTeal,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.paragraphStyle: paragraphStyle],
                                 range: foundRange)
            }
        }

        linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        attributedText = string
    }

    private func initializeBaseStyles() {
        dataDetectorTypes = .link
        isUserInteractionEnabled = true
        isSelectable = true
        backgroundColor = UIColor.clear
        isEditable = false
        
        adjustsFontForContentSizeCategory = true
    }
}

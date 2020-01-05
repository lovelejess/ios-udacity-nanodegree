//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Jess Le on 1/3/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

@IBDesignable public class MemeTextField : UITextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeBaseStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeBaseStyles()
    }

    public override func prepareForInterfaceBuilder() {
        initializeBaseStyles()
    }

    private func initializeBaseStyles() {
        autocapitalizationType = .allCharacters
        defaultTextAttributes = getStrokeAttributes()
        borderStyle = .none
    }

    func getStrokeAttributes() -> [NSAttributedString.Key : Any] {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.paragraphStyle : paragraphStyle
        ]
        return strokeTextAttributes
    }
}

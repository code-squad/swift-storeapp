//
//  SectionLabel.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 30..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class SectionLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 1
    @IBInspectable var bottomInset: CGFloat = 1
    @IBInspectable var leftInset: CGFloat = 3
    @IBInspectable var rightInset: CGFloat = 3

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(
            top: topInset,
            left: leftInset,
            bottom: bottomInset,
            right: rightInset
        )
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset
        return contentSize
    }
}

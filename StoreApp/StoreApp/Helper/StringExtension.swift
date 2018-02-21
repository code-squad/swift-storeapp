//
//  StringExtension.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

extension String {
    var salesHighlight: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let emphasizeRange = NSRange(location: 0, length: self.count-1)
        attributedString.addAttribute(.font, value: Style.SalePrice().font!, range: emphasizeRange)
        return attributedString
    }

    var strike: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: self.count)
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: range)
        attributedString.addAttribute(.strikethroughColor, value: Style.NormalPrice().textColor, range: range)
        return attributedString
    }
}

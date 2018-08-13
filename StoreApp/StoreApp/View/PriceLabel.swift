//
//  PriceLabel.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class PriceLabel: UILabel {
    
    private let salePriceTextColor = UIColor.init(red: 54/256, green: 193/256, blue: 187/256, alpha: 1)
    
    func setNormalPrice(_ text: String?) {
        guard let text = text else {
            isHidden = true
            return
        }
        isHidden = false
        let attributeString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
    }
    
    func setSalePrice(_ text: String) {
        let textColor = salePriceTextColor
        self.text = text
        self.textColor = textColor
    }
}

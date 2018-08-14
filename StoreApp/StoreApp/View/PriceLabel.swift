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
    private let normalPriceFontSize: CGFloat = 13
    private let salePriceFontSize: CGFloat = 17
    
    convenience init(frame: CGRect, normalPrice: String) {
        self.init(frame: frame)
        text = normalPrice
        attributedText = setNormalPrice(normalPrice)
        textColor = UIColor.darkGray
        font = font.withSize(normalPriceFontSize)
    }
    
    convenience init(frame: CGRect, salePrice: String) {
        self.init(frame: frame)
        text = salePrice
        set(salePrice: salePrice)
    }
    
    private func setNormalPrice(_ text: String) -> NSMutableAttributedString {
        let attributeString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    private func set(salePrice: String) {
        self.text = salePrice
        textColor = salePriceTextColor
        font = UIFont.boldSystemFont(ofSize: salePriceFontSize)
    }
}

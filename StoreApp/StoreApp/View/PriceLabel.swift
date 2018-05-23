//
//  PriceLabel.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 23..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class PriceLabel: UILabel {
    
    enum PriceType {
        
        case normal
        case sale
        
        var font: UIFont {
            switch self {
            case .normal: return UIFont.systemFont(ofSize: 15)
            case .sale: return UIFont.boldSystemFont(ofSize: 18)
            }
        }
        
        var fontColor: UIColor {
            switch self {
            case .normal: return UIColor.lightGray
            case .sale: return UIColor(red: 0.416, green: 0.761, blue: 0.749, alpha: 1.0)
            }
        }
        
        var alignment: NSTextAlignment {
            switch self {
            case .normal: return .center
            case .sale: return .left
            }
        }
    }
    
    convenience init(_ priceType: PriceType , _ priceText: String) {
        self.init()
        font = priceType.font
        textColor = priceType.fontColor
        textAlignment = priceType.alignment
        if priceType == .sale {
            text = priceText
            return
        }
        let strikeThroughString: NSMutableAttributedString =  NSMutableAttributedString(string: priceText)
        strikeThroughString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, strikeThroughString.length))
        attributedText = strikeThroughString
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

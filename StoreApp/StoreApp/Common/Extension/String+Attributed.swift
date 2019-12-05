//
//  String+Attributed.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

extension String {
    func centerLineStyle(text: String,
               changeText: String,
               centerLine: Bool?,
               font: UIFont?,
               color: UIColor?) -> NSAttributedString {
        let range = (text as NSString).range(of: changeText)
        let attributedString = NSMutableAttributedString(string: text)
        
        if let _ = centerLine {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }
        
        if let font = font {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        
        if let color = color {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        }
        return attributedString
    }
}

//
//  BeautyStringDSL.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//
import Then
import UIKit

class BeautyStringDSL {
    
    var string: NSMutableAttributedString
    private var range: NSRange
    private var paragraphStyle: NSMutableParagraphStyle = .init()
    
    init(_ string : NSMutableAttributedString) {
        self.string = string
        self.range = NSRange(location: 0, length: self.string.length)
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        string.addAttributes([.font: font], range: range)
        return self
    }
    
    @discardableResult
    func fgColor(_ color: UIColor) -> Self {
        string.addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    @discardableResult
    func bgColor(_ color: UIColor) -> Self {
        string.addAttributes([.backgroundColor: color], range: range)
        return self
    }
    
    @discardableResult
    func spacing(_ gap: Double) -> Self {
        string.addAttributes([.kern: gap], range: range)
        return self
    }
    
    @discardableResult
    func strikethrough(_ width: Double) -> Self {
        string.addAttribute(.strikethroughStyle, value: width, range: range)
        return self
    }
    
    @discardableResult
    func align(_ alignment: NSTextAlignment) -> Self {
        paragraphStyle.alignment = alignment
        string.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        return self
    }
}

extension BeautyStringDSL: Then {}

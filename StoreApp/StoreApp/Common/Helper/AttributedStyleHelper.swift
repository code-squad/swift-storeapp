//
//  AttributedStyleHelper.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

struct Style {
    enum Attribute {
        case font(UIFont)
        case color(UIColor)
        case centerLine(NSUnderlineStyle)
        
        var key: NSAttributedString.Key {
            switch self {
            case .font: return .font
            case .color: return .foregroundColor
            case .centerLine: return .strikethroughStyle
            }
        }
        
        var value: Any {
            switch self {
            case let .font(font): return font
            case let .color(color): return color
            case let .centerLine(style): return style.rawValue
            }
        }
    }
    
    var attributes: [Attribute] = []
}

// MARK: - Setting

extension Style {
    func font(_ font: UIFont) -> Style {
        return set(.font(font))
    }
    
    func color(_ foregroundColor: UIColor) -> Style {
        return set(.color(foregroundColor))
    }
    
    func centerLine(_ line: NSUnderlineStyle) -> Style {
        return set(.centerLine(line))
    }
    
    private func set(_ attribute: Attribute) -> Style {
        var style = self
        style.attributes.append(attribute)
        return style
    }
}

// MARK: - Apply

extension Style {
    func apply(text: String, changingText: String = "") -> NSAttributedString {
        let range = (text as NSString).range(of: changingText)
        let attributedString = NSMutableAttributedString(string: text)
        
        let styleAttributes = attributes.reduce(into: [:]) { (result, attribute) in
            result.updateValue(attribute.value, forKey: attribute.key)
        }
        attributedString.addAttributes(styleAttributes, range: range)
        return attributedString
    }
}

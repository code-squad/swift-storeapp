//
//  BadgeView.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import SnapKit

class BadgeView: UILabel {
    
    // MARK: - Properties
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += 10
        contentSize.width += 10
        return contentSize
    }
    
    // MARK: - initializer
    convenience init(style: Style, text: String) {
        self.init(frame: .zero)
        
        configure(style: style, text: text)
    }
    
    func configure(style: Style, text: String) {
        
        self.backgroundColor = style.bgColor
        self.layer.borderColor = style.borderColor.cgColor
        self.layer.borderWidth = 1
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.beauty
            .fgColor(style.textColor)
            .align(style.align)
            .font(style.font)
        self.attributedText = attributedText
    }
}

// MARK: - BadgeView.Style

extension BadgeView {
    
    enum Style: CaseIterable {
        case soldOut
        case bargainPrice
        case gift
        case none
        
        // MARK: - Initializer
        
        init(_ title: String) {
            for style in Style.allCases {
                if title.hasSuffix(style.keyWord) {
                    self = style
                    return
                }
            }
            self = .none
        }
        
        // MARK: - Attributes
        
        var bgColor: UIColor {
            switch self {
            case .soldOut:
                return .badgeBlack
            case .bargainPrice:
                return .badgePurple
            case .gift:
                return .badgeYellow
            case .none:
                return .white
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .none:
                return .lightGray
            default:
                return .white
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .soldOut:
                return .badgeBlack
            case .bargainPrice:
                return .badgePurple
            case .gift:
                return .badgeYellow
            case .none:
                return .lightGray
            }
        }
        
        var align: NSTextAlignment {
            return .center
        }
        
        var font: UIFont {
            return .badgeFont
        }
        
        var keyWord: String {
            switch self {
            case .soldOut:
                return "품절"
            case .bargainPrice:
                return "특가"
            case .gift :
                return "증정"
            case .none:
                return ""
            }
        }
    }
}

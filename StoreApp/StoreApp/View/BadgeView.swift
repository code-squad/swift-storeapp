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
        
        let attributedText = NSMutableAttributedString(string: text)
        self.backgroundColor = style.bgColor
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
        
        // MARK: - Initializer
        
        init?(_ title: String) {
            for style in Style.allCases {
                if title.hasSuffix(style.keyWord) {
                    self = style
                    return
                }
            }
            return nil
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
            }
        }
        
        var textColor: UIColor {
            return .white
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
            }
        }
    }
}

//
//  BadgeView.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class BadgeView: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

// MARK: - BadgeView.Style

extension BadgeView {
    
    enum Style: CaseIterable {
        case soldOut
        case bargainPrice
        case gift
        
        
        init?(_ title: String) {
            for style in Style.allCases {
                if title.hasSuffix(style.keyWord) {
                    self = style
                    return
                }
            }
            return nil
        }
        
        
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

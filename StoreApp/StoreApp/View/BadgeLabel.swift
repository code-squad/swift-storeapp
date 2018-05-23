//
//  BadgeLabel.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 23..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {
    
    enum BadgeType {
        case event
        case launching
        case soldout
        
        var text: String {
            switch self {
            case .event: return "이벤트특가"
            case .launching: return "론칭특가"
            case .soldout: return "품절"
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .event: return UIColor(red: 0.582, green: 0.216, blue: 1.000, alpha: 1.0)
            case .launching: return UIColor(red: 0.963, green: 0.881, blue: 0.144, alpha: 1.0)
            case .soldout: return UIColor.black
            }
        }
    }
    
    convenience init(_ badgeType: BadgeType) {
        self.init()
        font = UIFont.boldSystemFont(ofSize: 15)
        textAlignment = .center
        textColor = UIColor.white
        text = badgeType.text
        backgroundColor = badgeType.backgroundColor
        clipsToBounds = true
        cornerRadius = 2
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

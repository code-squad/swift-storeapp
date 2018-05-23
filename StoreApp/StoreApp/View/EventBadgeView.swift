//
//  EventBadgeView.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 23..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class EventBadgeView: UIStackView {

    enum Badge {
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
        
    }
    
    func setBadges(_ badgeTexts: [String]) {
        self.subviews.forEach({$0.removeFromSuperview()})
        for oneBadgeText in badgeTexts {
            let oneBadge = generateBadge(oneBadgeText)
            addArrangedSubview(oneBadge)
        }
        sizeToFit()
    }
    
    func generateBadge(_ badgeText: String) -> BadgeLabel {
        switch badgeText {
        case Badge.event.text: return BadgeLabel(.event)
        case Badge.launching.text: return BadgeLabel(.launching)
        case Badge.soldout.text: return BadgeLabel(.soldout)
        default: return BadgeLabel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

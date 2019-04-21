//
//  BadgeStackView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class BadgeStackView: UIStackView {

    func add(badges: [String]) {
        for badgeText in badges {
            let badge = BadgeLabel(frame: .zero)
            badge.text = badgeText
            self.addArrangedSubview(badge)
        }
    }
}

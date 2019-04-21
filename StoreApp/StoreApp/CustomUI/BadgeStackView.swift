//
//  BadgeStackView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class BadgeStackView: UIStackView {

    func addBadges(_ texts: [String]) {
        for text in texts {
            addBadge(text)
        }
    }
    
    func addBadge(_ text: String) {
        let badgeLabel = BadgeLabel(frame: .zero)
        badgeLabel.text = text
        self.addArrangedSubview(badgeLabel)
    }
}

//
//  Badgeself.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class BadgeLabel: InsetLabel, StyleConfigurable {

    convenience init(text: String) {
        let insets = Style.Badges.insets
        self.init(insets: insets)
        self.text = text
        configure()
    }

    func configure() {
        self.textAlignment = Style.Badges.textAlignment
        self.font = Style.Badges.font
        self.textColor = Style.Badges.textColor
        if let badgeType = Style.BadgeType(rawValue: text!) {
            self.backgroundColor = badgeType.color
        }
        self.layer.cornerRadius = Style.Badges.cornerRadius
        self.clipsToBounds = Style.Badges.clipsToBounds
    }

    override func reset() {
        super.reset()
        self.text = nil
        self.font = nil
        self.textColor = nil
        self.backgroundColor = nil
        self.layer.cornerRadius = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

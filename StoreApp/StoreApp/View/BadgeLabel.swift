//
//  Badgeself.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel, StyleConfigurable {
    private let topInset: CGFloat = Style.Badges.topPadding
    private let leftInset: CGFloat = Style.Badges.leftPadding
    private let bottomInset: CGFloat = Style.Badges.bottomPadding
    private let rightInset: CGFloat = Style.Badges.rightPadding

    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
        if let badgeType = Style.BadgeType(rawValue: text) {
            self.backgroundColor = badgeType.color
        }
        configure()
    }

    func configure() {
        self.textAlignment = Style.Badges.textAlignment
        self.font = Style.Badges.font
        self.textColor = Style.Badges.textColor
        self.layer.cornerRadius = Style.Badges.cornerRadius
        self.clipsToBounds = Style.Badges.clipsToBounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawText(in rect: CGRect) {
        let insets =
            UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += leftInset + rightInset
        size.height += topInset + bottomInset
        return size
    }
}

//
//  Badgeself.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel, StyleConfigurable {
    private var topInset: CGFloat = Style.Badges.topPadding
    private var leftInset: CGFloat = Style.Badges.leftPadding
    private var bottomInset: CGFloat = Style.Badges.bottomPadding
    private var rightInset: CGFloat = Style.Badges.rightPadding

    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
        configure()
        configurePriority()
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

    func reset() {
        self.text = nil
        self.font = nil
        self.textColor = nil
        self.backgroundColor = nil
        self.layer.cornerRadius = 0
        self.topInset = 0
        self.leftInset = 0
        self.bottomInset = 0
        self.rightInset = 0
    }

    private func configurePriority() {
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.setContentCompressionResistancePriority(.init(757), for: .horizontal)
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

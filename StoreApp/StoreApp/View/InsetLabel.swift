//
//  InsetLabel.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {

    private var topInset: CGFloat = 0
    private var leftInset: CGFloat = 0
    private var bottomInset: CGFloat = 0
    private var rightInset: CGFloat = 0

    func setInsets(insets: UIEdgeInsets) {
        self.topInset = insets.top
        self.leftInset = insets.left
        self.bottomInset = insets.bottom
        self.rightInset = insets.right
    }

    convenience init(insets: UIEdgeInsets) {
        self.init(frame: .zero)
        self.topInset = insets.top
        self.leftInset = insets.left
        self.bottomInset = insets.bottom
        self.rightInset = insets.right
        self.configureToFitContentSize()
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

    func reset() {
        self.topInset = 0
        self.leftInset = 0
        self.bottomInset = 0
        self.rightInset = 0
    }
}

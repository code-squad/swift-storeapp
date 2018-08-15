//
//  BadgeLabel.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 14..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {
    
    private let topInset: CGFloat = 3.0
    private let bottomInset: CGFloat = 3.0
    private let leftInset: CGFloat = 5.0
    private let rightInset: CGFloat = 5.0
    private let badgeBackgroundColor = UIColor(red: 168/255, green: 117/255, blue: 188/255, alpha: 1)
    
    convenience init(frame: CGRect, text: String) {
        self.init(frame: frame)
        self.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        textAlignment = .center
        textColor = .white
        backgroundColor = badgeBackgroundColor
        font = font.withSize(13)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}

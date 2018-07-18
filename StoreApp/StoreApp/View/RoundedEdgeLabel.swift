//
//  RoundedEdgeLabel.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 15..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

@IBDesignable class RoundedEdgeLabel: UILabel {

    init() {
        super.init(frame: CGRect.zero)
        self.font = self.font.withSize(14.0)
        font = font.bold()
        self.adjustsFontSizeToFitWidth = true
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 2, left: 8, bottom: 5, right: 8)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        self.textColor = UIColor.white
        self.textAlignment = .center
        layer.cornerRadius = frame.height / 7
        clipsToBounds = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    func custom(withText: DiscountBadge) -> RoundedEdgeLabel {
        switch withText {
        case .Launching:
            self.text = withText.rawValue
            self.backgroundColor = UIColor(r: 204, g: 147, b: 238)
            return self
        case .Event:
            self.text = withText.rawValue
            self.backgroundColor = UIColor(r: 255, g: 211, b: 79)
            return self
        }
    }

}

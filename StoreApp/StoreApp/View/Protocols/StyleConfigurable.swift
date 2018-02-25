//
//  Configurable.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol StyleConfigurable {
    func configure()
}

extension UILabel {
    func configure(style: UILabelPresentable) {
        if style.isBold {
            self.font = UIFont.boldSystemFont(ofSize: style.fontSize)
        } else {
            self.font.withSize(style.fontSize)
        }
        self.textColor = style.textColor
        self.textAlignment = style.textAlignment
    }

}

extension UIView {
    func configureToFitContentSize() {
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.setContentCompressionResistancePriority(.init(757), for: .horizontal)
    }
}

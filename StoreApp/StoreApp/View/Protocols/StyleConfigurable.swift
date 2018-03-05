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
    func configure(label: UILabel, style: UILabelPresentable)
}

extension StyleConfigurable {
    func configure(label: UILabel, style: UILabelPresentable) {
        if style.isBold {
            label.font = UIFont.boldSystemFont(ofSize: style.fontSize)
        } else {
            label.font.withSize(style.fontSize)
        }
        label.textColor = style.textColor
        label.textAlignment = style.textAlignment
    }
}

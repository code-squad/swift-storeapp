//
//  BadgesView.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class BadgesContainer: UIStackView, Appendable, Resizable, StyleConfigurable {

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure() {
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 4
    }

    func appendItems(with data: [String]?) {
        data?.forEach {
            let label = BadgeLabel(text: $0)
            self.addArrangedSubview(label)
        }
        resizeContainer()
    }

}

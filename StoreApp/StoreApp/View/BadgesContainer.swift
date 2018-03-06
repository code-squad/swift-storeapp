//
//  BadgesView.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class BadgesContainer: UIStackView, StyleConfigurable {

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
    }

    func removeAllBadges() {
        for case let label as BadgeLabel in arrangedSubviews {
            // 단순히 서브뷰만 떼어내는 게 아니라, 기존 서브뷰들의 속성을 리셋해줘야 한다.
            label.reset()
            self.removeArrangedSubview(label)
        }
    }
}

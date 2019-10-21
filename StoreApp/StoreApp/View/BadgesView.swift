//
//  BadgeView.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class BadgesView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(badgeItems: [String]) {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        badgeItems
            .map({ title in
                let badgeLabel = UILabel()

                badgeLabel.text = "  \(title)  "
                badgeLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                badgeLabel.textColor = .white

                return badgeLabel
            })
            .forEach { self.addArrangedSubview($0) }
    }
}

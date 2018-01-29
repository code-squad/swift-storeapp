//
//  BadgesView.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 29..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class BadgesView: UIView {

    var count: Int {
        return subviews.count
    }
    struct TagNumber {
        static let first = 999
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setBadges(tags: [String]?) {
        guard let badges = tags else { return }
        badges.forEach {
            let label = BadgeLabel(text: $0)
            if count == 0 { label.tag = TagNumber.first }
            label.backgroundColor = Badge.colors[$0]
            self.addSubview(label)
        }
        setLayout()
    }

    func setLayout() {
        var previous = 0
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            if $0.tag == TagNumber.first {
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            } else {
                $0.leadingAnchor
                    .constraint(equalTo: subviews[previous].trailingAnchor, constant: 3)
                    .isActive = true
                previous += 1
            }
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        }
    }
}

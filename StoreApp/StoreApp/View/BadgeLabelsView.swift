//
//  BadgeLabelsView.swift
//  StoreApp
//
//  Created by 윤동민 on 15/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class BadgeLabelsView: UIStackView {
    @IBOutlet var badgeLabels: [UILabel]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func makeHidden() {
        for label in badgeLabels {
            label.text = ""
            label.backgroundColor = UIColor.white
            label.isHidden = true
        }
    }
    
    func set(_ badge: [String]?) {
        makeHidden()
        guard let badge = badge else { return }
        for index in 0..<badge.count {
            badgeLabels[index].isHidden = false
            badgeLabels[index].text = badge[index]
            badgeLabels[index].textColor = UIColor.white
            badgeLabels[index].backgroundColor = UIColor.purple
        }
    }
}

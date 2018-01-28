//
//  BadgeLabel.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 29..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(text: String) {
        let frame = CGRect(x: 0, y: 0, width: 30*text.count, height: 26)
        super.init(frame: frame)
        self.frame = frame
        self.text = text
        self.font = UIFont(name: "EuphemiaUCAS-Bold", size: 17)
        self.textColor = UIColor.white
        self.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

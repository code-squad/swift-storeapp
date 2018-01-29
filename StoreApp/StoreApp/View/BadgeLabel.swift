//
//  BadgeLabel.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 29..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {

    struct Size {
        static let font: CGFloat = 17
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(text: String) {
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        self.frame = frame
        self.text = text
        self.font = UIFont.euphemiaUCAS(ofSize: Size.font)
        self.textColor = UIColor.white
        self.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

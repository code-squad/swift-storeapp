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
        static let origin = CGPoint.zero
        static let fontSize: CGFloat = 17
        static func size(_ textCount: Int) -> CGSize {
            return CGSize(width: 30*textCount, height: 26)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(text: String) {
        let frame = CGRect(origin: Size.origin, size: Size.size(text.count))
        super.init(frame: frame)
        self.frame = frame
        self.text = text
        self.font = UIFont.euphemiaUCAS(ofSize: Size.fontSize)
        self.textColor = UIColor.white
        self.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

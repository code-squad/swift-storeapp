//
//  BadgeView.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class BadgeView: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String) {
        self.init()
        
        self.text = title
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.textColor = .white
    }
}

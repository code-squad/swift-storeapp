//
//  PriceLabelsView.swift
//  StoreApp
//
//  Created by 윤동민 on 12/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class PriceLabelsView: UIStackView {
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func set(_ s_price: String, _ n_price: String?) {
        if let n_price = n_price {
            firstLabel.text = n_price
            firstLabel.attributedText = NSAttributedString(string: n_price, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            firstLabel.textColor = UIColor.lightGray
            firstLabel.font = firstLabel.font.withSize(15)
            secondLabel.text = s_price
            secondLabel.font = secondLabel.font.withSize(17)
            secondLabel.textColor = UIColor.init(displayP3Red: 0, green: 0.55, blue: 0.55, alpha: 1.0)
            firstLabel.isHidden = false
            secondLabel.isHidden = false
        } else {
            firstLabel.text = s_price
            firstLabel.font = secondLabel.font.withSize(17)
            firstLabel.textColor = UIColor.init(displayP3Red: 0, green: 0.55, blue: 0.55, alpha: 1.0)
            firstLabel.isHidden = false
            secondLabel.isHidden = true
        }
    }
}

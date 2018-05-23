//
//  PriceView.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 22..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class PriceView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPriceLabels(_ item: Item) {
        self.subviews.forEach({$0.removeFromSuperview()})
        if let n_price = item.n_price {
            addArrangedSubview(PriceLabel(.normal, n_price))
        }
        addArrangedSubview(PriceLabel(.sale, item.s_price))
    }

}

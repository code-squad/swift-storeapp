//
//  PriceView.swift
//  StoreApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class PriceView: UIStackView {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(from item: StoreItem) {
        hiddenViewItem()

        // nPrice
        if let price = item.n_price, let firstLabel = self.arrangedSubviews[0] as? UILabel {
            firstLabel.isHidden = false
            firstLabel.attributedText = decorateString(option: .nPrice, string: price)
        }

        // sPrice
        guard let secondLabel = self.arrangedSubviews[1] as? UILabel else { return }
        secondLabel.isHidden = false
        secondLabel.attributedText = decorateString(option: .sPrice, string: item.s_price)
    }
    
    private func hiddenViewItem() {
        for subview in self.arrangedSubviews {
            subview.isHidden = true
        }
    }
    
    private func decorateString(option: PriceAttribute, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}

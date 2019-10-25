//
//  MenuCell.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit


class MenuCell : UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var salePrice: UILabel!
    @IBOutlet weak var badges: UIStackView!
    
    override func prepareForReuse() {
        for subView in badges.arrangedSubviews{
            badges.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
    
    func setData(item:StoreItem){
       self.title.text = item.title
       self.desc.text = item.description
       self.salePrice.attributedText = strokeLabel(text: item.n_price ?? "")
       self.originalPrice.text = item.s_price
       item.badge?.forEach({ v in
           self.badges.addArrangedSubview(badgeLabel(text:v))
       })
    }
    private func badgeLabel(text:String) -> UILabelPadding{
        let label = UILabelPadding()
        label.text = text
        label.textColor = .white
        label.backgroundColor = UIColor(red: 119/255, green: 52/255, blue: 208/255, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }
    private func strokeLabel(text:String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

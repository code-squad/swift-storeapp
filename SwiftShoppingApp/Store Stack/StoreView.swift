//
//  StoreView.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 12/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import UIKit


// # MARK: - View

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var subheadLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    
    var tagLabels: [UILabel] = []
    
    var imageURL: String = ""
    
    func setUpUI() {
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
        mainImageView.layer.masksToBounds = true
    }
    
    func setProductInfo(info: StoreItem) {
        
        setUpUI()
        
        headLabel.text = info.title
        subheadLabel.text = info.description
        originalPriceLabel.text = "7,500"
        salePriceLabel.text = info.s_price
        
        let fixedHeight: CGFloat = 22
        var labelX = headLabel.frame.origin.x
        let labelY = salePriceLabel.frame.origin.y + salePriceLabel.frame.height + 6.0
        let labelGap: CGFloat = 3.0
        let labelMargin: CGFloat = 4.0
        
        while tagLabels.count < info.delivery_type.count {
            tagLabels.append(createTagLabel())
        }
        
        tagLabels.forEach { label in label.alpha = 0 }
        
        for (label, deliveryType) in zip(tagLabels, info.delivery_type) {
            label.alpha = 1
            label.text = deliveryType
            label.sizeToFit()
            label.frame = CGRect(x: labelX, y: labelY,
                                 width: label.frame.width + labelMargin*2,
                                 height: fixedHeight)

            labelX += label.frame.width + labelGap
        }
        
        self.mainImageView?.image = nil
        imageURL = info.image
        info.loadImage { image, url in
            if self.imageURL == url {
                self.mainImageView?.image = image
            }
        }
    }
    
    func createTagLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.backgroundColor = UIColor(red: 170.0/255.0, green: 116.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        
        self.addSubview(label)
        return label
    }
}


class StoreSectionHeader: UITableViewCell {
    @IBOutlet weak var subtitleLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        subtitleLabel.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        subtitleLabel.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        // cell 재사용전에 호출되는 함수
        subtitleLabel.setTitle("", for: .normal)
        titleLabel.text = ""
    }
    
    func set(info sectionInfo: StoreSection?) {
        if let info = sectionInfo {
            subtitleLabel.setTitle(info.subtitle, for: .normal)
            titleLabel.text = info.title
        }
    }
}




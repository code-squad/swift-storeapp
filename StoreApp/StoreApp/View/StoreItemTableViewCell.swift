//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class StoreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    override func prepareForReuse() {
        priceStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        itemImageView.image = nil
    }
    
    func setThumbnailImage(with setter: StoreItemImageSettable) {
        let imagePath = ImageManager.imagePath(string: setter.imageURL)
        itemImageView.image = UIImage(contentsOfFile: imagePath)
    }
    
    func setLabel(with setter: StoreItemLabelTextSettable) {
        titleLabel.text = setter.title
        descriptionLabel.text = setter.description
        setNormalPrice(setter.normalPrice)
        setSalePrice(setter.salePrice)
        setBadges(setter.badges)
    }
        
    private func setNormalPrice(_ normalPrice: String?) {
        guard let normalPrice = normalPrice else { return }
        priceStackView.addArrangedSubview(PriceLabel(frame: .zero, normalPrice: normalPrice))
    }
    
    private func setSalePrice(_ salePrice: String) {
        let salePriceLabel = PriceLabel(frame: .zero, salePrice: salePrice)
        priceStackView.addArrangedSubview(salePriceLabel)
    }
    
    private func setBadges(_ badges: [String]?) {
        guard let badges = badges else { return }
        badges.forEach { badgeStackView.addArrangedSubview(BadgeLabel(frame: .zero, text: $0)) }
    }
    
}

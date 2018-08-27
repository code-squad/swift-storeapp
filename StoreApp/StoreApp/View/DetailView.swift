//
//  DetailView.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func orderButtonDidTapped(_ orderButton: UIButton)
}

protocol DetailViewLabelSettable {
    var productDescription: String { get }
    var point: String { get }
    var prices: [String] { get }
    var deliveryInfo: String { get }
    var deliveryFee: String { get }
}

class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
    @IBOutlet weak var thumbnailImagesScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var detailSectionStackView: UIStackView!
    
    @IBAction func orderItem(_ sender: UIButton) {
        delegate?.orderButtonDidTapped(sender)
    }
    
    func setTitleLabelText(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setDetailLabelText(with setter: DetailViewLabelSettable) {
        self.descriptionLabel.text = setter.productDescription
        self.pointLabel.text = setter.point
        self.deliveryInfoLabel.text = setter.deliveryInfo
        self.deliveryFeeLabel.text = setter.deliveryFee
        self.priceLabel.text = setter.prices.last
    }
    
    func addTopThumbnailImages(_ data: Data) {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(data: data)
        imageView.contentMode = .scaleAspectFill
        let originX: CGFloat = self.frame.width * CGFloat(thumbnailImagesScrollView.subviews.count - 1)
        imageView.frame = CGRect(x: originX, y: 0, width: self.frame.width, height: thumbnailImagesScrollView.frame.height)
        thumbnailImagesScrollView.addSubview(imageView)
        thumbnailImagesScrollView.contentSize.width += imageView.frame.width
    }
}

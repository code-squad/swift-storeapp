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
    func didAddDetailImage(_ height: CGFloat)
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
    
    func addThumbnailImage(_ data: Data) {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(data: data)
        imageView.contentMode = .scaleAspectFill
        let originX: CGFloat = self.frame.width * CGFloat(thumbnailImagesScrollView.subviews.count - 1)
        imageView.frame = CGRect(x: originX, y: 0, width: self.frame.width, height:thumbnailImagesScrollView.frame.height)
        thumbnailImagesScrollView.addSubview(imageView)
        thumbnailImagesScrollView.contentSize.width += imageView.frame.width
    }
    
    func addImageViewToDetailSection() {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        detailSectionStackView.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func addImageToDetailSection(at index: Int, _ imageData: Data) {
        guard let imageView = detailSectionStackView.arrangedSubviews[index] as? UIImageView else { return }
        guard let image = UIImage(data: imageData) else { return }
        imageView.image = image
        // 이미지의 비율을 유지하면서 뷰의 크기를 조절.
        let imageViewHeight = image.size.height / image.size.width * imageView.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
    }
}

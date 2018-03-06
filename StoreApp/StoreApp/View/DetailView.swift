//
//  DetailView.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func orderButtonDidTapped()
}

class DetailView: UIView {
    weak var orderDelegate: DetailViewDelegate?
    @IBOutlet weak var contentsScrollView: UIScrollView!
    @IBOutlet weak var thumbnailScrollView: UIScrollView!
    @IBOutlet weak var infoLabelsContainer: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var detailSection: UIStackView!
    private var items: ItemDetail?

    @IBAction func order(_ sender: UIButton) {
        orderDelegate?.orderButtonDidTapped()
    }

    func setContents(_ items: ItemDetail) {
        self.items = items
        setThumbnailScrollView()
        setInfoLabelsContainer()
        setDetailSection()
        setContentSize()
    }

    private func setContentSize() {
        contentsScrollView.contentSize.height += thumbnailScrollView.bounds.height
        contentsScrollView.contentSize.height += infoLabelsContainer.bounds.height
        contentsScrollView.contentSize.height += detailSection.bounds.height
    }

    private func setThumbnailScrollView() {
        guard let items = items else { return }
        layoutIfNeeded()
        for (index, thumbnailImage) in items.data.thumbnails.enumerated() {
            let thumbnailFrame = CGRect(x: CGFloat(index)+CGFloat(index)*thumbnailScrollView.frame.width,
                                        y: 0,
                                        width: thumbnailScrollView.frame.width,
                                        height: thumbnailScrollView.frame.height)
            let thumbnailView = UIImageView(frame: thumbnailFrame)
            thumbnailView.contentMode = .scaleAspectFit
            thumbnailView.image = thumbnailImage
            thumbnailScrollView.addSubview(thumbnailView)
            thumbnailScrollView.contentSize.width += thumbnailScrollView.frame.width
        }
    }

    private func setInfoLabelsContainer() {
        guard let items = items else { return }
        title.text = items.data.productDescription
        titleDescription.text = items.data.productDescription
        price.text = items.data.prices.first
        point.text = items.data.point
        deliveryInfo.text = items.data.deliveryInfo
        deliveryFee.text = items.data.deliveryFee
    }

    private func setDetailSection() {
        guard let items = items else { return }
        items.data.detailSectionItems.forEach { [unowned self] in
            let detailImageView = UIImageView(frame:
                CGRect(x: 0, y: 0, width: self.detailSection.frame.width, height: 0))
            detailImageView.image = $0
            self.detailSection.addArrangedSubview(detailImageView)
            // 이미지뷰의 contentMode를 scaleAspectFit으로만 설정하면 이미지 사이의 간격이 넓어지므로, 제약조건으로 이미지 크기 조절.
            detailImageView.translatesAutoresizingMaskIntoConstraints = false
            detailImageView.widthAnchor.constraint(equalTo: detailSection.widthAnchor, multiplier: 1).isActive = true
            detailImageView.heightAnchor.constraint(equalTo: detailImageView.widthAnchor,
                                                    multiplier: $0.size.height/$0.size.width).isActive = true
        }
    }

}

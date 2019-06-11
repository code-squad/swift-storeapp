//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 17..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class DetailViewController: ReachabilityViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var naturalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var thumbScrollView: ThumbScrollView!
    @IBOutlet weak var detailStackView: DetailStackView!
    
    var titleText: String!
    
    weak var delegate: DetailViewControllerDelegate?
    var detailPresenter: DetailPresenter? {
        didSet {
            detailPresenter?.attach(detailView: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailPresenter?.initViewController()
    }
    
    @IBAction func touchUpOrderButton(_ sender: UIButton) {
        let userName = Configuration.userName
        guard let price = salePriceLabel.text,
            let title = titleLabel.text else { return }
        let message = "\(userName) - \(price) - \(title)"
        delegate?.post(orderMessage: message)
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: DetailView {
    
    func show(with detailInfo: DetailInfo) {
        titleLabel.text = titleText
        descriptionLabel.text = detailInfo.product_description
        pointLabel.text = detailInfo.point
        deliveryInfoLabel.text = detailInfo.delivery_info
        deliveryFeeLabel.text = detailInfo.delivery_fee
        if let salePrice = detailInfo.prices.last {
            salePriceLabel.text = salePrice
        }
        if detailInfo.prices.count == 2,
            let naturalPrice = detailInfo.prices.first {
            naturalPriceLabel.attributedText = naturalPrice.strikeThrough()
            naturalPriceLabel.isHidden = false
        }
        thumbScrollView.show(with: detailInfo.thumb_images)
        detailStackView.show(with: detailInfo.detail_section)
    }
}

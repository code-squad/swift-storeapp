//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 17..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit
import JSONDataFetcher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var naturalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var thumbScrollView: ThumbScrollView!
    @IBOutlet weak var detailStackView: UIStackView!
    
    var titleText: String!
    
    weak var delegate: DetailViewControllerDelegate?
    var detailPresenter: DetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailPresenter?.initViewController()
    }
    
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
        showThumbScrollView(with: detailInfo.thumb_images)
        showDetailStackView(with: detailInfo.detail_section)
    }
    
    private func showThumbScrollView(with imageURLs: [String]) {
        thumbScrollView.setContentSize(imageURLs.count)
        for (index, imageURL) in imageURLs.enumerated() {
            let successHandler = { (data: Data) -> Void in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: image)
                    let xPosition = self.thumbScrollView.frame.width * CGFloat(index)
                    imageView.frame = CGRect(x: xPosition,
                                             y: 0,
                                             width: self.thumbScrollView.frame.width,
                                             height: self.thumbScrollView.frame.height)
                    imageView.contentMode = .scaleAspectFill
                    self.thumbScrollView.addSubview(imageView)
                }
            }
            let jsonDataFetcher = JSONDataFetcher()
            guard let url = URL(string: imageURL) else { continue }
            jsonDataFetcher.load(url: url, completion: successHandler)
        }
    }
    
    private func showDetailStackView(with imageURLs: [String]) {
        for imageURL in imageURLs {
            let imageView = UIImageView()
            let successHandler = { [unowned imageView](data: Data) -> Void in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.sizeToFit()
                    let ratio = CGFloat(imageView.frame.height / imageView.frame.width)
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                                      multiplier: ratio).isActive = true
                }
            }
            guard let url = URL(string: imageURL) else { continue }
            let jsonDataFetcher = JSONDataFetcher()
            detailStackView.addArrangedSubview(imageView)
            jsonDataFetcher.load(url: url, completion: successHandler)
        }
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

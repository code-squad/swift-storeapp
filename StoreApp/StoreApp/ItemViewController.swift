//
//  ItemViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 29..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, OrderDelegate {
    @IBOutlet weak var thumbnailScrollView: ItemDetailScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabels: UIStackView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var detailScrollView: ItemDetailScrollView!
    @IBOutlet weak var buyButton: UIButton!
    var itemData: DetailHash! {
        didSet {
            self.detailInfo = itemData.detailItemInfo()
        }
    }
    var detailInfo: DetailItemInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setThumbnailScrollView(notification:)),
                                               name: .thumbnailDownloaded,
                                               object: ImageSetter.self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setDetailScrollView(notification:)),
                                               name: .detailImageDownloaded,
                                               object: ImageSetter.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard itemData != nil else { return }
        setTitleLabels()
        setPriceLabel()
        setPointLabel()
        setDeliveryInfoLabel()
        setDeliveryFeeLabel()
        setThumbnailImages()
        setDetailImages()
    }

    private func setThumbnailImages() {
        ImageSetter.downloadDetailImages(urls: self.detailInfo.thumbImages,
                                completion: Notification.Name.thumbnailDownloaded)
    }

    private func setDetailImages() {
        ImageSetter.downloadDetailImages(urls: self.detailInfo.detailSection,
                                completion: Notification.Name.detailImageDownloaded)
    }

    @objc func setThumbnailScrollView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let imageData = userInfo[Notification.Name.thumbnailDownloaded] as? [Data?] else { return }

        let scrollImages: [UIImageView] = imageData.map {
            if let data = $0 {
                return UIImageView(image: UIImage(data: data))
            } else {
                return UIImageView(image: UIImage(named: Keyword.refreshImage.rawValue))
            }
        }
        self.thumbnailScrollView.isPagingEnabled = true
        self.thumbnailScrollView.setScrollView(images: scrollImages)
    }

    @objc func setDetailScrollView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let imageData = userInfo[Notification.Name.detailImageDownloaded] as? [Data?] else { return }

        let scrollImages: [UIImageView] = imageData.map {
            if let data = $0 {
                return UIImageView(image: UIImage(data: data))
            } else {
                return UIImageView(image: UIImage(named: Keyword.refreshImage.rawValue))
            }
        }

        self.detailScrollView.setScrollView(images: scrollImages)
    }

    private func setTitleLabels() {
        titleLabel.text = itemData.itemTitle
        descriptionLabel.text = detailInfo.productDescription
    }

    private func setPriceLabel() {
        guard let nPriceLabel = priceLabels.arrangedSubviews[0] as? UILabel else {return}
        guard let sPriceLabel = priceLabels.arrangedSubviews[1] as? UILabel else {return}

        if detailInfo.prices.count > 1 {
            nPriceLabel.text = detailInfo.prices[0]
            sPriceLabel.text = detailInfo.prices[1]
        } else {
            nPriceLabel.isHidden = true
            sPriceLabel.text = detailInfo.prices[0]
        }
    }

    private func setPointLabel() {
        pointLabel.text = detailInfo.point
    }

    private func setDeliveryInfoLabel() {
        deliveryInfo.numberOfLines = 0
        deliveryInfo.text = detailInfo.deliveryInfo
    }

    private func setDeliveryFeeLabel() {
        deliveryFee.text = detailInfo.deliveryFee
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func orderButtonTapped(_ sender: Any) {
        let purchasedItem = OrderItem(title: itemData.itemTitle,
                                      prices: itemData.detailItemInfo().prices)
        order(product: purchasedItem)
        self.navigationController?.popViewController(animated: true)
    }

}


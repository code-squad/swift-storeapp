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
                                               object: self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setDetailScrollView(notification:)),
                                               name: .detailImageDownloaded,
                                               object: self)
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
        self.downloadItemImages(urls: self.detailInfo.thumbImages,
                                completion: Notification.Name.thumbnailDownloaded)
    }

    private func setDetailImages() {
        self.downloadItemImages(urls: self.detailInfo.detailSection,
                                completion: Notification.Name.detailImageDownloaded)
    }

    private func downloadItemImages(urls: [String], completion: Notification.Name) {
        var images = [UIImageView]()
        urls.forEach { imageURL in
            ImageSetter.download(with: imageURL, handler: { imageData in
                DispatchQueue.main.async { [weak self] in
                    if let loadedData = imageData {
                        let image = UIImageView(image: UIImage(data: loadedData))
                        images.append(image)
                    } else {
                        let image = UIImageView(image: UIImage(named: Keyword.refreshImage.rawValue))
                        images.append(image)
                    }
                    if images.count == urls.count {
                        NotificationCenter.default.post(name: completion, object: self, userInfo: [completion:images])
                    }
                }
            })
        }
    }

    @objc func setThumbnailScrollView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let images = userInfo[Notification.Name.thumbnailDownloaded] as? [UIImageView] else { return }

        self.thumbnailScrollView.isPagingEnabled = true
        self.thumbnailScrollView.setScrollView(images: images)
    }

    @objc func setDetailScrollView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let images = userInfo[Notification.Name.detailImageDownloaded] as? [UIImageView] else { return }
        self.detailScrollView.setScrollView(images: images)
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


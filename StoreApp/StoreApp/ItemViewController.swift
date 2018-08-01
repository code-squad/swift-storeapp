//
//  ItemViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 29..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var thumbnailScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabels: UIStackView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var buyButton: UIButton!
    var itemData: DetailHash! {
        didSet {
            self.detailInfo = itemData.detailItemInfo()
        }
    }
    var detailInfo: DetailItemInfo!
    var thumbnailImages = [UIImageView]()
    var detailImages = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setThumbnailScrollView),
                                               name: .thumbnailDownloaded,
                                               object: self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setDetailScrollView),
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
        buyButton.layer.zPosition = 1
    }

    private func setThumbnailImages() {
        self.downloadItemImages(urls: self.detailInfo.thumbImages)
        // download와 scrollview세팅
    }

    private func downloadItemImages(urls: [String]) {
        urls.forEach { imageURL in
            ImageSetter.download(with: imageURL, handler: { imageData in
                DispatchQueue.main.async { [weak self] in
                    if let loadedData = imageData {
                        let image = UIImageView(image: UIImage(data: loadedData))
                        self?.thumbnailImages.append(image)
                        if self?.thumbnailImages.count == urls.count {
                            NotificationCenter.default.post(name: .thumbnailDownloaded, object: self)
                        }
                    } else {
                        let image = UIImageView(image: UIImage(named: Keyword.refreshImage.rawValue))
                        self?.thumbnailImages.append(image)
                        if self?.thumbnailImages.count == urls.count {
                            NotificationCenter.default.post(name: .thumbnailDownloaded, object: self)
                        }
                    }
                }
            })
        }
    }

    @objc func setThumbnailScrollView() {
        self.thumbnailScrollView.isPagingEnabled = true
        for i in 0..<thumbnailImages.count {
            thumbnailImages[i].contentMode = .scaleAspectFill
            thumbnailImages[i].clipsToBounds = true
            let xPosition = self.view.frame.width * CGFloat(i)
            thumbnailImages[i].frame = CGRect(x: xPosition, y: 0, width: self.thumbnailScrollView.frame.width, height: self.thumbnailScrollView.frame.height)
            thumbnailScrollView.contentSize.width = self.view.frame.width * CGFloat(i+1)
            thumbnailScrollView.addSubview(thumbnailImages[i])
        }
    }

    private func setDetailImages() {
        self.downloadDetailImages(urls: self.detailInfo.detailSection)
    }

    private func downloadDetailImages(urls:[String]) {
        urls.forEach { imageURL in
            ImageSetter.download(with: imageURL, handler: { imageData in
                DispatchQueue.main.async { [weak self] in
                    if let loadedData = imageData {
                        let image = UIImageView(image: UIImage(data: loadedData))
                        self?.detailImages.append(image)
                        if self?.detailImages.count == urls.count {
                            NotificationCenter.default.post(name: .detailImageDownloaded, object: self)
                        }
                    } else {
                        let image = UIImageView(image: UIImage(named: Keyword.refreshImage.rawValue))
                        self?.detailImages.append(image)
                        if self?.detailImages.count == urls.count {
                            NotificationCenter.default.post(name: .detailImageDownloaded, object: self)
                        }
                    }
                }
            })
        }
    }

    @objc func setDetailScrollView() {
        detailScrollView.contentSize.height = self.detailScrollView.frame.height * CGFloat(detailImages.count)
        for i in 0..<detailImages.count {
            detailImages[i].contentMode = .scaleAspectFill
            detailImages[i].clipsToBounds = true
            let yPosition = self.detailScrollView.frame.height * CGFloat(i)
            detailImages[i].frame = CGRect(x: self.detailScrollView.frame.origin.x, y: yPosition,
                                           width: self.detailScrollView.frame.width, height: self.detailScrollView.frame.height)
            detailScrollView.addSubview(detailImages[i])
        }
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

    }

}

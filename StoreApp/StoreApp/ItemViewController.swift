//
//  ItemViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 29..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var itemImages: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabels: UIStackView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var detailView: UIScrollView!
    @IBOutlet weak var buyButton: UIButton!
    var itemData: DetailHash! {
        didSet {
            self.detailInfo = itemData.detailItemInfo()
        }
    }
    var detailInfo: DetailItemInfo!
    var thumbnailImages = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

    private func setThumbnailImages() {
        self.downloadItemImages(urls: self.detailInfo.thumbImages)
    }

    private func downloadItemImages(urls: [String]) {
        urls.forEach { imageURL in
            ImageSetter.download(with: imageURL, handler: { imageData in
                DispatchQueue.main.async { [weak self] in
                    if let loadedData = imageData {
                        let image = UIImageView(image: UIImage(data: loadedData))
                        self?.thumbnailImages.append(image)
                        if self?.thumbnailImages.count == urls.count {
                            // download thumbnail finished
                        }
                    } else {
                        let image = UIImageView(image: UIImage(named: Keyword.refreshImage.rawValue))
                        self?.thumbnailImages.append(image)
                        if self?.thumbnailImages.count == urls.count {
                            // download thumbnail finished
                        }
                    }
                }
            })
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

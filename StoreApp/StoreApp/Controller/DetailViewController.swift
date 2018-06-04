//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 24..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var itemDetail: ItemDetail!

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var thumbnailsView: UIScrollView!
    @IBOutlet weak var detailInfoView: UIView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailPoint: UILabel!
    @IBOutlet weak var detailDeliveryInfo: UILabel!
    @IBOutlet weak var detailDeliveryFee: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailsView.isPagingEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailView(notification:)), name: .loadDetailData , object: nil)
    }
    
    @objc private func updateDetailView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let detailData = userInfo[Keyword.Observer.detailData.name] as? DetailData else { return }
        guard let title = userInfo[Keyword.Observer.itemDetailTitle.name] as? String else { return }
        updateDetailInfo(detailData, title)
    }
    
    private func updateDetailInfo(_ data: DetailData, _ itemDetailTitle: String) {
        detailTitle.text = itemDetailTitle
        detailDescription.text = data.product_description
        detailPoint.text = data.point
        detailDeliveryFee.text = data.delivery_fee
        detailDeliveryInfo.text = data.delivery_info
        guard let price = data.prices.last else { return }
        detailPrice.text = price
        drawThumbnailsView(data.thumb_images)
        drawDetailSection(data.detail_section)
    }
    
    private func drawThumbnailsView(_ URLs: [String]) {
        var xPosition: CGFloat = Keyword.viewFloat.zero.value
        for index in URLs.indices {
            let oneThumbnail = UIImageView(frame: CGRect(x: xPosition, y: Keyword.viewFloat.zero.value,
                                                         width: UIScreen.main.bounds.width, height: thumbnailsView.frame.height))
            oneThumbnail.contentMode = .scaleAspectFit
            Downloader.loadURLImage(URLs[index]) { (result) in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async { oneThumbnail.image = UIImage(data: data) }
                case .failure(): oneThumbnail.backgroundColor = .gray
                }
            }
            thumbnailsView.addSubview(oneThumbnail)
            xPosition += thumbnailsView.frame.width
        }
        thumbnailsView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(URLs.count),
                                            height: thumbnailsView.frame.height)
    }
    
    private func drawDetailSection(_ URLs: [String]) {
        var yPosition: CGFloat = detailInfoView.frame.origin.y + detailInfoView.frame.height
        mainScrollView.contentSize = CGSize(width: mainScrollView.frame.width,
                                            height: yPosition + Keyword.viewFloat.detailSectionHeight.value * CGFloat(URLs.count))
        for index in URLs.indices {
            let oneDetailSection = UIImageView(frame: CGRect(x: Keyword.viewFloat.zero.value,
                                                             y: yPosition,
                                                             width: UIScreen.main.bounds.width,
                                                             height: Keyword.viewFloat.detailSectionHeight.value))
            oneDetailSection.contentMode = .scaleAspectFit
            Downloader.loadURLImage(URLs[index]) { (result) in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async { oneDetailSection.image = UIImage(data: data) }
                case .failure(): oneDetailSection.backgroundColor = .gray
                }
            }
            mainScrollView.addSubview(oneDetailSection)
            yPosition += Keyword.viewFloat.detailSectionHeight.value
        }
    }
}

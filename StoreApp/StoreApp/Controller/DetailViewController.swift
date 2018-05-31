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
    }

}

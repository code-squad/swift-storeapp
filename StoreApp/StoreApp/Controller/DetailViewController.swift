//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 24..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailInfoDelegate {
    
    var itemDetail: ItemDetail!
    
    @IBOutlet weak var thumbnailsView: UIScrollView!
    @IBOutlet weak var detailInfoView: UIView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailPoint: UILabel!
    @IBOutlet weak var detailDeliveryInfo: UILabel!
    @IBOutlet weak var detailDeliveryFee: UILabel!
    @IBOutlet weak var detailSectionView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailsView.isPagingEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailView(notification:)), name: .loadDetailData , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateThumbnails(notification:)), name: .thumbnail, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailSection(notification:)), name: .detailSection, object: nil)
    }
    
    @objc private func updateThumbnails(notification: Notification) {
        DispatchQueue.main.async {
            guard let userInfo = notification.userInfo else { return }
            guard let thumbnail = userInfo[Keyword.Observer.thumbnailData.name] as? (data: Data, index: Int) else { return }
            self.drawThumbnailsView(thumbnail.data, thumbnail.index)
        }
    }
    
    @objc private func updateDetailView(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let detailData = userInfo[Keyword.Observer.detailData.name] as? DetailData else { return }
        guard let title = userInfo[Keyword.Observer.itemDetailTitle.name] as? String else { return }
        drawDetailInfoView(detailData, title)
    }
    
    @objc private func updateDetailSection(notification: Notification) {
        DispatchQueue.main.async {
            guard let userInfo = notification.userInfo else { return }
            guard let detailSection = userInfo[Keyword.Observer.detailSectionData.name] as? (data: Data, index: Int) else { return }
            self.drawDetailSectionView(detailSection.data, detailSection.index)
        }
    }
    
    @IBAction func didTouchedOrderButton(_ sender: UIButton) {
        order()
        navigationController?.popViewController(animated: true)
    }
    
    private func drawThumbnailsView(_ thumbnailData: Data, _ thumbnailIndex: Int) {
        let xPosition: CGFloat = thumbnailsView.frame.width * CGFloat(thumbnailIndex)
        let oneThumbnail = UIImageView(frame: CGRect(x: xPosition, y: Keyword.viewFloat.zero.value,
                                                     width: UIScreen.main.bounds.width, height: thumbnailsView.frame.height))
        oneThumbnail.contentMode = .scaleAspectFit
        oneThumbnail.image = UIImage(data: thumbnailData)
        thumbnailsView.addSubview(oneThumbnail)
        thumbnailsView.contentSize = CGSize(width: UIScreen.main.bounds.width * Keyword.viewFloat.thumbnailsCount.value,
                                            height: thumbnailsView.frame.height)
    }
    
    private func drawDetailInfoView(_ data: DetailData, _ itemDetailTitle: String) {
        detailTitle.text = itemDetailTitle
        detailDescription.text = data.product_description
        detailPoint.text = data.point
        detailDeliveryFee.text = data.delivery_fee
        detailDeliveryInfo.text = data.delivery_info
        guard let price = data.prices.last else { return }
        detailPrice.text = price
    }
    
    private func drawDetailSectionView(_ detailSectionData: Data, _ detailSectionIndex: Int) {
        let baseYPosition: CGFloat = detailInfoView.frame.origin.y + detailInfoView.frame.height
        let oneDetailSection = UIImageView(frame: CGRect(x: Keyword.viewFloat.zero.value,
                                                         y: baseYPosition + Keyword.viewFloat.detailSectionHeight.value * CGFloat(detailSectionIndex),
                                                         width: UIScreen.main.bounds.width,
                                                         height: Keyword.viewFloat.detailSectionHeight.value))
        oneDetailSection.contentMode = .scaleAspectFit
        oneDetailSection.image = UIImage(data: detailSectionData)
        detailSectionView.addSubview(oneDetailSection)
        detailSectionView.contentSize = CGSize(width: detailSectionView.frame.width,
                                               height: baseYPosition + Keyword.viewFloat.detailSectionHeight.value * Keyword.viewFloat.detailSectionCount.value)
    }
    
    func order() {
        guard let url = URL(string: Keyword.ItemDetail.order.URL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = Keyword.httpMethod.name
        let detailInfoString = "\(detailPrice.text ?? "")-\(detailTitle.text ?? "")"
        let detailInfoData = try? JSONSerialization.data(withJSONObject: [Keyword.payLoadText.name : detailInfoString])
        request.httpBody = detailInfoData
        URLSession.shared.dataTask(with: request).resume()
    }

}

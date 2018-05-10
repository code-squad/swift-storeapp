//
//  DetailViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 24..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailHash: String?
    var detailTitle: String?
    var detailDescription: String?

    @IBOutlet weak var thumbnailsView: UIScrollView!
    @IBOutlet weak var contentsView: UIView!

    @IBOutlet weak var contentsTitle: UILabel!
    @IBOutlet weak var contentsDescription: UILabel!

    @IBOutlet weak var contentsPoint: UILabel!
    @IBOutlet weak var contentsDeliveryInfo: UILabel!
    @IBOutlet weak var contentsDeliveryFee: UILabel!
    @IBOutlet weak var contentsPrice: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        showDetail()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showDetail(notification:)),
            name: .detailInformation,
            object: nil
        )
    }

    private func showDetail() {
        contentsTitle.text = detailTitle
        contentsDescription.text = detailDescription
        let communicator = Communicator()
        communicator.detailInformation(with: detailHash!)
    }

    @objc private func showDetail(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let detailInformation = userInfo["detailInformation"] as? DetailInformation else { return }
        DispatchQueue.main.async {
            self.contentsPoint.text = detailInformation.point
            self.contentsDeliveryInfo.text = detailInformation.deliveryInfo
            self.contentsDeliveryFee.text = detailInformation.deliveryFee
            self.contentsPrice.text = detailInformation.prices[0]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailViewController: DetailinfoDelegate {
    func order() {

    }
}

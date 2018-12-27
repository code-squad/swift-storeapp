//
//  DetailViewController.swift
//  StoreApp
//
//  Created by oingbong on 20/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var storeDetail = StoreDetail()
    @IBOutlet var detailView: DetailView!
    weak var delegate: OrderToast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        netwo
        detailView.delegate = self
    }
    
    func configure(with hash: String, title: String) {
        storeDetail.parseURL(with: hash) { (detailItem) in
            DispatchQueue.main.async {
                self.detailView.configure(with: detailItem, title: title)
            }
        }
    }
}

// MARK: post Slack
extension DetailViewController: Orderable {
    func orderToSlack(with orderSheet: OrderSheet) {
        NetworkManager.slackUrl(with: orderSheet) { (isSuccess) in
            self.delegate?.show(with: orderSheet, status: isSuccess)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Observers
extension DetailViewController {
    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatus(_:)), name: NotificationKey.networkStatus, object: nil)
    }
    
    @objc private func networkStatus(_ notification: Notification) {
        guard let status = notification.userInfo?["status"] as? NetworkStatus else { return }
        self.view.layer.borderColor = status.color
        self.view.layer.borderWidth = status.width
    }
}

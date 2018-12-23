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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        NetworkManager.slackUrl(with: orderSheet) { (_) in
            // 디테일 뷰 닫고 이전화면 돌아가기
        }
    }
}

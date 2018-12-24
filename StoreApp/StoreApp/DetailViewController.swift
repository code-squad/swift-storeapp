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
    private let titleSuccess = "주문성공"
    private let titleFail = "주문실패"
    private let messageSuccess = "😍 배송이 시작되면 또 안내드릴게요! 😍"
    private let messageFail = "😱 주문에 실패하였습니다. 다시 주문해주세요! 😱"
    private let buttonTitle = "확인"
    
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
        NetworkManager.slackUrl(with: orderSheet) { (isSuccess) in
            self.alert(isSuccess)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func alert(_ isSuccess: Bool) {
        let title = isSuccess ? titleSuccess : titleFail
        let message = isSuccess ? messageSuccess : messageFail
        let alertButtonTitle = buttonTitle
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertButtonTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

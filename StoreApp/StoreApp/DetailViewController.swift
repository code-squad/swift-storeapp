//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Reusable, DetailViewDelegate {
    var detailHash: String?
    private var items: ItemDetail?
    var detailView: DetailView! {
        return self.view as? DetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as? DetailView)?.orderDelegate = self
        loadItemsFromAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    private func loadItemsFromAPI() {
        guard let url = URL(string: "http://crong.codesquad.kr:8080/woowa/detail/"+detailHash!) else { return }
        do {
            let contents = try Data(contentsOf: url)
            self.items = try JSONDecoder().decode(ItemDetail.self, from: contents)
        } catch {
            NSLog(error.localizedDescription)
        }
        presentView()
    }

    func  presentView() {
        if let items = self.items {
            self.detailView.setContents(items)
        }
    }

    func orderButtonDidTapped() {
        let urlString = "https://hooks.slack.com/services/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"
        let price = String(describing: items!.data.prices.first!)
        let menu = String(describing: items!.data.productDescription)
        let payload = ["text": "- 주문자: Min,\n - 가격: \(price),\n - 메뉴: \(menu)"]
        do {
            let payloadData = try JSONSerialization.data(withJSONObject: payload, options: .init(rawValue: 0))
            Downloader.post(to: urlString, with: payloadData)
        } catch {
            NSLog(error.localizedDescription)
        }
        self.navigationController?.popViewController(animated: true)
    }

}

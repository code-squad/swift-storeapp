//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster

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
        guard let url = URL(string: Server.remote.api.detail!+detailHash!) else { return }
        do {
            let contents = try Data(contentsOf: url)
            self.items = try JSONDecoder().decode(ItemDetail.self, from: contents)
        } catch {
            presentErrorAlert(errorType: .loadFail, shouldBackToPrevScreen: true)
        }
        presentView()
    }

    func  presentView() {
        if let items = self.items {
            self.detailView.setContents(items)
        }
    }

    func orderButtonDidTapped() {
        let urlString = Server.remote.api.slackHook!
        let price = String(describing: items!.data.prices.first!)
        let menu = String(describing: items!.data.productDescription)
        let payload = SlackBody.text(OrderMessage.slack(price: price, menu: menu)).payload
        var payloadData = Data()
        do {
            payloadData = try JSONSerialization.data(withJSONObject: payload, options: .init(rawValue: 0))
        } catch {
            presentErrorAlert(errorType: .jsonDecodeFail)
        }
        Downloader.post(to: urlString, with: payloadData) { [unowned self] error in
            self.presentErrorAlert(errorType: error)
        }
        self.navigationController?.popViewController(animated: true)
    }

    func presentErrorAlert(errorType: NetworkError, shouldBackToPrevScreen: Bool=false) {
        let alert = UIAlertController(title: errorType.alert.title,
                                      message: errorType.alert.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            shouldBackToPrevScreen ? self.navigationController?.popViewController(animated: true) : nil
            return
        })
        self.present(alert, animated: true, completion: nil)
    }

}

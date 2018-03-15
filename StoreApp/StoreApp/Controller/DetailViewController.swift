//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster

class DetailViewController: UIViewController, Reusable, RespondableForNetwork {
    var detailHash: String?
    private var items: ItemDetail?
    var detailView: DetailView! {
        return self.view as? DetailView
    }
    weak var delegate: OrderResultDelegate?
    var reachabilityMonitor: ReachabilityMonitor? {
        didSet {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(onConnectionChanged(_:)),
                                                   name: .connectionChanged, object: nil)
        }
    }

    @objc private func onConnectionChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let isAvailable = userInfo["NetworkStatus"] as? Bool else { return }
        drawBorder(on: self.view, when: isAvailable)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as? DetailView)?.orderDelegate = self
        loadItemsFromAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        if let monitor = reachabilityMonitor {
            drawBorder(on: self.view, when: monitor.isAvailable)
        }
    }

    private func loadItemsFromAPI() {
        guard let url = URL(string: Server.remote.api.detail!+detailHash!) else { return }
        do {
            let contents = try Data(contentsOf: url)
            self.items = try JSONDecoder().decode(ItemDetail.self, from: contents)
            self.items?.data.thumbnails.forEach { $0.delegate = self }
            self.items?.data.detailSectionItems.forEach { $0.delegate = self }
        } catch {
            presentError(.loadFail)
        }
        presentView()
    }

    func  presentView() {
        if let items = self.items {
            self.detailView.setContents(items)
        }
    }

}

extension DetailViewController: DetailViewDelegate {
    func orderButtonDidTapped() {
        guard let items = items else { return }
        let urlString = Server.remote.api.slackHook!
        let price = String(describing: items.data.prices.first!)
        let menu = String(describing: items.data.productDescription)
        let orderInfo = OrderInfo(price: price, menu: menu)
        let payload = SlackBody.text(OrderMessage.slack(orderInfo)).payload
        var payloadData = Data()
        do {
            payloadData = try JSONSerialization.data(withJSONObject: payload, options: .init(rawValue: 0))
        } catch {
            presentError(.jsonDecodeFail)
        }
        Downloader.post(to: urlString, with: payloadData) { [unowned self] error in
            self.presentError(error)
        }
        self.navigationController?.popViewController(animated: true)
        delegate?.toastOrderResult(orderInfo)
    }
}

extension DetailViewController: PresentImageDelegate {
    func present(_ contentType: AsyncPresentable, image: UIImage) {
        switch contentType {
        case is Thumbnail: self.detailView.configureThumbnailScrollView(image)
        case is DetailImage: self.detailView.configureDetailSection(image)
        default: break
        }
    }

}

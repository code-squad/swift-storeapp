//
//  DetailViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 24..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var storeItem: StoreItem?

    @IBOutlet weak var mainScrollView: UIScrollView!
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

    func setStoreItem(with storeItem: StoreItem) {
        self.storeItem = storeItem
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
        guard let storeItem = storeItem else { return }
        contentsTitle.text = storeItem.title
        contentsDescription.text = storeItem.description
        let communicator = Communicator()
        communicator.detailInformation(with: storeItem.detailHash)
    }

    @objc private func showDetail(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let detailInformation = userInfo["detailInformation"] as? DetailInformation else { return }
        DispatchQueue.main.async {
            self.setThumbnailImages(with: detailInformation.thumbImages)
            self.contentsPoint.text = detailInformation.point
            self.contentsDeliveryInfo.text = detailInformation.deliveryInfo
            self.contentsDeliveryFee.text = detailInformation.deliveryFee
            self.contentsPrice.text = detailInformation.prices[0]
            self.setDetailSection(with: detailInformation.detailSection)
        }
    }

    private func setThumbnailImages(with urlStrings: [String]) {
        thumbnailsView.isPagingEnabled = true
        for index in urlStrings.indices {
            guard let url = URL(string: urlStrings[index]) else { return }
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let topImageView = self.getThumbnailImageView(from: data, index: index)
                    self.thumbnailsView.addSubview(topImageView)
                    let contentWidth = UIScreen.main.bounds.width * CGFloat(urlStrings.count)
                    self.thumbnailsView.contentSize = CGSize(width: contentWidth,
                                                             height: self.thumbnailsView.frame.size.height)
                }
            }).resume()
        }
    }

    private func getThumbnailImageView(from data: Data, index: Int) -> UIImageView {
        let topImage = UIImage(data: data)
        let imageFrame = CGRect(x: self.thumbnailsView.frame.size.width * CGFloat(index),
                                y: self.thumbnailsView.frame.origin.y,
                                width: self.thumbnailsView.frame.size.width,
                                height: self.thumbnailsView.frame.size.height)
        let topImageView = UIImageView(frame: imageFrame)
        topImageView.image = topImage
        topImageView.contentMode = .scaleAspectFill
        return topImageView
    }

    private func setDetailSection(with urlStrings: [String]) {
        var detailSectionHeight = self.thumbnailsView.frame.height + self.contentsView.frame.height
        for index in urlStrings.indices {
            guard let url = URL(string: urlStrings[index]) else { return }
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    guard let detailImage = UIImage(data: data) else { return }
                    let imageRatio = UIScreen.main.bounds.width / detailImage.size.width
                    let detailImageView = self.getImageView(from: detailImage,
                                                            yPosition: detailSectionHeight,
                                                            ratio: imageRatio)
                    detailSectionHeight += detailImage.size.height * imageRatio
                    self.addImageViewToScrollView(with: detailImageView, detailSectionHeight: detailSectionHeight)
                }
            }).resume()
        }
    }

    private func getImageView(from detailImage: UIImage, yPosition: CGFloat, ratio: CGFloat) -> UIImageView {
        let imageFrame = CGRect(x: 0,
                                y: yPosition,
                                width: detailImage.size.width * ratio,
                                height: detailImage.size.height * ratio)
        let detailImageView = UIImageView(frame: imageFrame)
        detailImageView.image = detailImage
        detailImageView.contentMode = .scaleAspectFit
        return detailImageView
    }

    private func addImageViewToScrollView(with detailImageView: UIImageView, detailSectionHeight: CGFloat) {
        self.mainScrollView.addSubview(detailImageView)
        self.mainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                                 height: detailSectionHeight)
    }

    @IBAction func order(_ sender: Any) {
        order()
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailViewController: DetailinfoDelegate {
    func order() {
        let urlString = Keyword.Order.url.value
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(Keyword.Order.headerValue.value, forHTTPHeaderField: Keyword.Order.headerField.value)
        request.httpMethod = Keyword.Order.httpMethod.value
        let data = ["text": "\((storeItem?.title)!) - \(contentsPrice.text!)"]
        guard let json = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        request.httpBody = json
        URLSession.shared.dataTask(with: request).resume()
    }
}

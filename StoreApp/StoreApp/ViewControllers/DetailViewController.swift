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
                if let data = data {
                    DispatchQueue.main.async {
                        let topImage = UIImage(data: data)
                        let imageFrame = CGRect(x: self.thumbnailsView.frame.size.width * CGFloat(index),
                                                y: self.thumbnailsView.frame.origin.y,
                                                width: self.thumbnailsView.frame.size.width,
                                                height: self.thumbnailsView.frame.size.height)
                        let topImageView = UIImageView(frame: imageFrame)
                        topImageView.image = topImage
                        topImageView.contentMode = .scaleAspectFill
                        self.thumbnailsView.addSubview(topImageView)
                        let contentWidth = UIScreen.main.bounds.width * CGFloat(urlStrings.count)
                        self.thumbnailsView.contentSize = CGSize(width: contentWidth,
                                                                 height: self.thumbnailsView.frame.size.height)
                    }
                }
            }).resume()
        }
    }

    private func setDetailSection(with urlStrings: [String]) {
        var detailSectionHeight: CGFloat = 0
        for index in urlStrings.indices {
            guard let url = URL(string: urlStrings[index]) else { return }
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        guard let detailImage = UIImage(data: data) else { return }
                        let yOrigin = self.thumbnailsView.frame.height + self.contentsView.frame.height
                        let imageRatio = UIScreen.main.bounds.width / detailImage.size.width
                        let imageFrame = CGRect(x: 0,
                                                y: detailSectionHeight + yOrigin,
                                                width: detailImage.size.width * imageRatio,
                                                height: detailImage.size.height * imageRatio)
                        let detailImageView = UIImageView(frame: imageFrame)
                        detailImageView.image = detailImage
                        detailImageView.contentMode = .scaleAspectFit
                        self.mainScrollView.addSubview(detailImageView)
                        detailSectionHeight += detailImage.size.height * imageRatio
                        self.mainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                                                 height: yOrigin + detailSectionHeight)
                    }
                }
            }).resume()
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

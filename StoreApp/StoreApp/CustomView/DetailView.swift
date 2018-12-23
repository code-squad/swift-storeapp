//
//  DetailView.swift
//  StoreApp
//
//  Created by oingbong on 21/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DetailView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var detailSection: UIScrollView!
    @IBOutlet weak var orderButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var pointTitleLabel: UILabel!
    @IBOutlet weak var deliveryInfoTitleLabel: UILabel!
    @IBOutlet weak var deliberyFeeTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    
    func configure(with item: DetailItem) {
        // MARK: Scroll View
        configureScrollView(with: item)
    }
    
    private func configureScrollView(with item: DetailItem) {
        let itemCount = item.thumbImages.count
        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(itemCount), height: scrollView.frame.height)
        for index in 0..<itemCount {
            let fileName = item.thumbImages[index].components(separatedBy: "/").last!
            let isExist = LocalFileManager.fileExists(fileName: fileName)
            if isExist {
                addThumbImage(with: fileName)
            } else {
                downloadThumbImage(with: item.thumbImages[index])
            }
        }
    }
    
    private func addThumbImage(with fileName: String) {
        guard let data = LocalFileManager.imageData(with: fileName) else { return }
        let imageView = UIImageView(image: UIImage(data: data))
        imageView.contentMode = .scaleAspectFill
        let xValue = scrollView.frame.width * CGFloat(scrollView.subviews.count - 3)
        imageView.frame = CGRect(x: xValue, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.addSubview(imageView)
    }
    
    private func downloadThumbImage(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        download(with: url) { (fileName) in
            DispatchQueue.main.async {
                self.addThumbImage(with: fileName)
            }
        }
    }
    
    private func download(with url: URL, handler: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            Parser.imageDownLoad(with: url, handler: { (fileName) in
                handler(fileName)
            })
        }
    }
}

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
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var detailSection: UIStackView!
    @IBOutlet weak var orderButton: UIButton!
    
    weak var delegate: Orderable?
    private let customer = "오잉봉"
    private let basicPropertyScrollView = 2
    
    func configure(with item: DetailItem, title: String) {
        // MARK: Scroll View
        configureScrollView(with: item)
        
        // MARK: Info
        descriptionView.configure(with: item, title: title)
        
        // MARK: Detail Section
        configureDetailSection(with: item)
    }
    
    private func download(with url: URL, handler: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            NetworkManager.imageDownLoad(with: url, handler: { (fileName) in
                handler(fileName)
            })
        }
    }
    
    // MARK: Scroll View
    private func configureScrollView(with item: DetailItem) {
        let itemCount = item.thumbImages.count
        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(itemCount), height: scrollView.frame.height)
        for index in 0..<itemCount {
            guard let fileName = item.thumbImages[index].components(separatedBy: "/").last else { continue }
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
        let xValue = scrollView.frame.width * CGFloat(scrollView.subviews.count - basicPropertyScrollView)
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
    
    // MARK: Detail Section
    private func configureDetailSection(with item: DetailItem) {
        let itemCount = item.detailSection.count
        for index in 0..<itemCount {
            guard let fileName = item.detailSection[index].components(separatedBy: "/").last else { continue }
            let isExist = LocalFileManager.fileExists(fileName: fileName)
            if isExist {
                addDetailSection(with: fileName)
            } else {
                downloadDetailSection(with: item.detailSection[index])
            }
        }
    }
    
    private func addDetailSection(with fileName: String) {
        guard let data = LocalFileManager.imageData(with: fileName) else { return }
        guard let image = UIImage(data: data) else { return }
        let imageView = UIImageView(image: image)
        // MARK: 줄어든 이미지의 넓이만큼 높이도 같은 비율로 줄이기 위한 것 입니다.
        let ratio = self.frame.width / imageView.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(image.size.height * ratio)).isActive = true
        detailSection.addArrangedSubview(imageView)
    }
    
    private func downloadDetailSection(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        download(with: url) { (fileName) in
            DispatchQueue.main.async {
                self.addDetailSection(with: fileName)
            }
        }
    }
    
    // MARK: Click Button
    @IBAction func clickOrder(_ sender: Any) {
        guard let (title, price) = descriptionView.itemInfo() as? (String, String) else { return }
        let orderSheet = OrderSheet(customer: customer, price: price, menu: title)
        delegate?.orderToSlack(with: orderSheet)
    }
}

// MARK: Reference
// StackView in ScrollView - https://medium.com/@jongwonwoo/uiscrollview-%EC%95%88%EC%97%90%EC%84%9C-uistackview-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-738a77355a8
// StackView Scroll - https://stackoverflow.com/questions/31668970/is-it-possible-for-uistackview-to-scroll

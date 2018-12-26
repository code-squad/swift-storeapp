//
//  ThumbnailView.swift
//  StoreApp
//
//  Created by oingbong on 26/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ThumbnailView: UIScrollView {
    private let basicPropertyScrollView = 2
    
    func configure(with item: DetailItem) {
        let itemCount = item.thumbImages.count
        self.contentSize = CGSize(width: (superview?.frame.width ?? 0) * CGFloat(itemCount), height: self.frame.height)
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
    
    func addThumbImage(with fileName: String) {
        guard let data = LocalFileManager.imageData(with: fileName) else { return }
        let imageView = UIImageView(image: UIImage(data: data))
        imageView.contentMode = .scaleAspectFill
        let xValue = self.frame.width * CGFloat(self.subviews.count - basicPropertyScrollView)
        imageView.frame = CGRect(x: xValue, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(imageView)
    }
    
    func downloadThumbImage(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        download(with: url) { (fileName) in
            DispatchQueue.main.async {
                self.addThumbImage(with: fileName)
            }
        }
    }
    
    private func download(with url: URL, handler: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            NetworkManager.imageDownLoad(with: url, handler: { (fileName) in
                handler(fileName)
            })
        }
    }
}

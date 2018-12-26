//
//  ThumbnailView.swift
//  StoreApp
//
//  Created by oingbong on 26/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ThumbnailView: UIScrollView, ImageGroup {
    private let basicPropertyScrollView = 2
    
    func configure(with item: DetailItem) {
        let itemCount = item.thumbImages.count
        self.contentSize = CGSize(width: (superview?.frame.width ?? 0) * CGFloat(itemCount), height: self.frame.height)
        for index in 0..<itemCount {
            guard let fileName = item.thumbImages[index].components(separatedBy: "/").last else { continue }
            let isExist = LocalFileManager.fileExists(fileName: fileName)
            if isExist {
                addImages(with: fileName)
            } else {
                downloadImages(with: item.thumbImages[index])
            }
        }
    }
    
    func addImages(with fileName: String) {
        guard let data = LocalFileManager.imageData(with: fileName) else { return }
        let imageView = UIImageView(image: UIImage(data: data))
        imageView.contentMode = .scaleAspectFill
        let xValue = self.frame.width * CGFloat(self.subviews.count - basicPropertyScrollView)
        imageView.frame = CGRect(x: xValue, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(imageView)
    }
    
    func downloadImages(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        NetworkManager.imageDownLoad(with: url, handler: { (fileName) in
            DispatchQueue.main.async {
                self.addImages(with: fileName)
            }
        })
    }
}

//
//  Thumbnail.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class Thumbnail {
    let url: String
    private(set) var image: UIImage?

    init(url: String) {
        self.url = url
        loadImage()
    }

    private func loadImage() {
        if let cachedData = CacheStorage.retrieve(url) {
            self.image = UIImage(data: cachedData)
        } else {
            Downloader.download(from: url, completionHandler: { response in
                switch response {
                case .success(let imageData):
                    CacheStorage.save(self.url, imageData)
                    self.image = UIImage(data: imageData)
                case .failure(let error): NSLog(error.localizedDescription)
                }
            })
        }
    }
}

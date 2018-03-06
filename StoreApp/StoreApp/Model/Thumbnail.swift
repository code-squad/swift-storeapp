//
//  Thumbnail.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class Thumbnail {
    private var urlString: String {
        set {
            url = URL(string: newValue)
        }
        get {
            guard let url = url else { return "" }
            return url.absoluteString
        }
    }
    private var url: URL?
    private(set) var image: UIImage?

    init(urlString: String) throws {
        self.urlString = urlString
        loadImage()
    }

    private func loadImage() {
        if let cachedData = CacheStorage.retrieve(urlString) {
            self.image = UIImage(data: cachedData)
        } else {
            Downloader.downloadToGlobalQueue(from: urlString, completionHandler: { response in
                switch response {
                case .success(let data):
                    CacheStorage.save(self.urlString, data)
                    self.image = UIImage(data: data)
                case .failure(let error):
                    if case let DownloadError.downloadFail(message: errorMessage) = error {
                        NSLog(errorMessage)
                    }
                }
            })
        }
    }

}

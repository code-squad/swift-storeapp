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
                    print(error)
                    let emptyView = UIView(frame: CGRect.zero)
                    emptyView.widthAnchor.constraint(equalToConstant: 100)
                    emptyView.heightAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 1)
                    emptyView.backgroundColor = UIColor.emerald
                    emptyView.setNeedsLayout()
                    let renderer = UIGraphicsImageRenderer(size: emptyView.frame.size)
                    let emptyImage = renderer.image(actions: { _ in
                        emptyView.drawHierarchy(in: emptyView.bounds, afterScreenUpdates: true)
                    })
                    self.image = emptyImage
                }
            })
        }
    }

}

//
//  DetailImage.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol PresentDetailImageDelegate: class {
    func present(detailImage: UIImage)
}

class DetailImage {
    weak var delegate: PresentDetailImageDelegate?
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
    private(set) var image: UIImage? {
        didSet {
            guard let image = image else { return }
            delegate?.present(detailImage: image)
        }
    }

    init(urlString: String) throws {
        self.urlString = urlString
        loadImage()
    }

    private func loadImage() {
        if let cachedData = CacheStorage.retrieve(urlString) {
            self.image = UIImage(data: cachedData)
        } else {
            Downloader.downloadToGlobalQueue(from: urlString, qos: .userInteractive, completionHandler: { response in
                switch response {
                case .success(let data):
                    try? CacheStorage.save(self.urlString, data)
                    self.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

}

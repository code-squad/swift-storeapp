//
//  AsyncPresentable.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 8..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol AsyncPresentable: class {
    func loadImage(from urlString: String)
    var image: UIImage? { get set }
}

extension AsyncPresentable {
    func loadImage(from urlString: String) {
        if let cachedData = CacheStorage.retrieve(urlString) {
            self.image = UIImage.init(data: cachedData)
        } else {
            Downloader.downloadToGlobalQueue(from: urlString, qos: .userInteractive, completionHandler: { response in
                switch response {
                case .success(let data):
                    try? CacheStorage.save(urlString, data)
                    self.image = UIImage(data: data)
                case .failure: self.presentGraySpace()
                }
            })
        }
    }

    private func presentGraySpace() {
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

}

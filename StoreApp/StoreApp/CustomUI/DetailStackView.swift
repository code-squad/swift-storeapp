//
//  DetailStackView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 30..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit
import JSONDataFetcher

class DetailStackView: UIStackView {

    func show(with imageURLs: [String]) {
        for imageURL in imageURLs {
            let imageView = UIImageView()
            let successHandler = { [unowned imageView](data: Data) -> Void in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.sizeToFit()
                    let ratio = CGFloat(imageView.frame.height / imageView.frame.width)
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                                      multiplier: ratio).isActive = true
                }
            }
            guard let url = URL(string: imageURL) else { continue }
            let jsonDataFetcher = JSONDataFetcher()
            self.addArrangedSubview(imageView)
            jsonDataFetcher.load(url: url, completion: successHandler)
        }
    }
}

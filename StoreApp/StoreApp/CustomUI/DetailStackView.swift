//
//  DetailStackView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 30..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit
import SDWebImage

class DetailStackView: UIStackView {

    func show(with imageURLs: [String]) {
        for imageURL in imageURLs {
            guard let url = URL(string: imageURL) else { continue }
            self.insertImageView(with: url)
        }
    }
    
    private func insertImageView(with imageURL: URL) {
        let imageView = UIImageView()
        self.addArrangedSubview(imageView)
        let successHandler = { () -> Void in
            DispatchQueue.main.async {
                imageView.sizeToFit()
                let ratio = CGFloat(imageView.frame.height / imageView.frame.width)
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                                  multiplier: ratio).isActive = true
            }
        }
        imageView.sd_setImage(with: imageURL) { (_, error, _, _) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            successHandler()
        }
    }
}

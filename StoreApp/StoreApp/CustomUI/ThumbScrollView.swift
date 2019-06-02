//
//  ThumbScrollView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 30..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit
import JSONDataFetcher

class ThumbScrollView: UIScrollView {
    
    func show(with imageURLs: [String]) {
        self.setContentSize(imageURLs.count)
        for (index, imageURL) in imageURLs.enumerated() {
            let successHandler = { (data: Data) -> Void in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: image)
                    let xPosition = self.frame.width * CGFloat(index)
                    imageView.frame = CGRect(x: xPosition,
                                             y: 0,
                                             width: self.frame.width,
                                             height: self.frame.height)
                    imageView.contentMode = .scaleAspectFill
                    self.addSubview(imageView)
                }
            }
            let jsonDataFetcher = JSONDataFetcher()
            guard let url = URL(string: imageURL) else { continue }
            jsonDataFetcher.load(url: url, completion: successHandler)
        }
    }
    
    private func setContentSize(_ countOfImage: Int) {
        DispatchQueue.main.async {
            self.contentSize.width = self.frame.width * CGFloat(countOfImage)
        }
    }
}

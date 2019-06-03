//
//  ThumbScrollView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 30..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit
import SDWebImage

class ThumbScrollView: UIScrollView {
    
    func show(with imageURLs: [String]) {
        self.setContentSize(imageURLs.count)
        for (index, imageURL) in imageURLs.enumerated() {
            insertImage(to: index, with: imageURL)
        }
    }
    
    private func setContentSize(_ countOfImage: Int) {
        DispatchQueue.main.async {
            self.contentSize.width = self.frame.width * CGFloat(countOfImage)
        }
    }
    
    private func insertImage(to index: Int, with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url)
        DispatchQueue.main.async {
            let xPosition = self.frame.width * CGFloat(index)
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: self.frame.width,
                                     height: self.frame.height)
            self.addSubview(imageView)
        }
    }
}

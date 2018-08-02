//
//  ItemDetailScrollView.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 8. 2..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ItemDetailScrollView: UIScrollView {

    var images: [UIImageView]!

    func setScrollView(images: [UIImageView]) {
        self.images = images
        self.images.forEach {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        switch self.isPagingEnabled {
        case true: self.paginatedView()
        case false: self.scrollableView()
        }
    }

    private func paginatedView() {
        for i in 0..<images.count {
            let xPosition = self.frame.width * CGFloat(i)
            images[i].frame = CGRect(x: xPosition, y: 0, width: self.frame.width, height: self.frame.height)
            self.contentSize.width = self.frame.width * CGFloat(i+1)
            self.addSubview(images[i])
        }
    }

    private func scrollableView() {
        self.contentSize.height = self.frame.height * CGFloat(images.count)
        for i in 0..<images.count {
            let yPosition = self.frame.height * CGFloat(i)
            images[i].frame = CGRect(x: 0, y: yPosition,
                                     width: self.frame.width, height: self.frame.height)
            self.addSubview(images[i])
        }
    }
}

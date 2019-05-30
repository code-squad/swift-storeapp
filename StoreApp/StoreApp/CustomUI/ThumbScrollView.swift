//
//  ThumbScrollView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 30..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ThumbScrollView: UIScrollView {
    
    func setContentSize(_ countOfImage: Int) {
        DispatchQueue.main.async {
            self.contentSize.width = self.frame.width * CGFloat(countOfImage)
        }
    }
}

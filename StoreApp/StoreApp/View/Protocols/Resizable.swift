//
//  Resizable.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol Resizable {
    func resizeContainer()
}

extension UIStackView {
    func resizeContainer() {
        var contentWidth: CGFloat = 0.0
        var contentHeight: CGFloat = 0.0
        self.arrangedSubviews.forEach {
            $0.invalidateIntrinsicContentSize()
            contentWidth += $0.intrinsicContentSize.width + self.spacing
            contentHeight = $0.intrinsicContentSize.height
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        self.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    }
}

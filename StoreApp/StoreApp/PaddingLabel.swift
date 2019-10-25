//
//  PaddingLable.swift
//  StoreApp
//
//  Created by Summer on 25/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

class UILabelPadding: UILabel {
    let padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}

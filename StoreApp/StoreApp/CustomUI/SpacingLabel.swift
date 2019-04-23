//
//  SpacingLabel.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 23..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class SpacingLabel: UILabel {

    //MARK: - Properties
    //MARK: Inset Value
    private let topInset: CGFloat = 3
    private let bottomInset: CGFloat = 3
    private let leftInset: CGFloat = 3
    private let rightInset: CGFloat = 3
    
    //MARK: - Methods
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

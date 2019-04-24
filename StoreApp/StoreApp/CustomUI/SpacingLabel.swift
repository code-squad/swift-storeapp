//
//  SpacingLabel.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 23..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

@IBDesignable
class SpacingLabel: UILabel {

    //MARK: - Properties
    //MARK: Inset Value
    private let insets = UIEdgeInsets(top: 3,
                                      left: 3,
                                      bottom: 3,
                                      right: 3)
    
    //MARK: - Methods
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        
        return CGSize(width: size.width + insets.left + insets.right,
                      height: size.height + insets.top + insets.bottom)
    }
}

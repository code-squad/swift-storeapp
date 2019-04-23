//
//  BadgeLabel.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class BadgeLabel: SpacingLabel {
    
    //MARK: - Properties
    //MARK: RGB Value
    private let redValue: CGFloat = 151
    private let greenValue: CGFloat = 91
    private let blueValue: CGFloat = 177
    
    //MARK: - Methods
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.textAlignment = .center
        self.textColor = .white
        self.font = .systemFont(ofSize: 9)
        self.backgroundColor = .init(red: redValue / 255,
                                     green: greenValue / 255,
                                     blue: blueValue / 255,
                                     alpha: 1)
    }
}

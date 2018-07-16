//
//  MenuHeaderView.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {
    var storeInfo: StoreInfo? {
        didSet {
            // ???: 여기서 View를 구성하는 것이 좋은가?
        }
    }
    
    var titleText: UIButton = UIButton(type: .custom)
    var descriptionLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        descriptionLabel.frame = CGRect(x: 0, y: 50, width: frame.size.width, height: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(descriptionLabel)
        
        titleText = UIButton(type: UIButtonType.custom)
        titleText.isUserInteractionEnabled = false
        titleText.contentEdgeInsets = UIEdgeInsetsMake(1, 2, 1, 2)
        titleText.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        titleText.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleText.layer.borderColor = UIColor.lightGray.cgColor
        titleText.layer.borderWidth = 1
        self.addSubview(titleText)
    }
    
    func titleLabelText(text: String) {
        titleText.setTitle(text, for: .normal)
        titleText.sizeToFit()
        titleText.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2-8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

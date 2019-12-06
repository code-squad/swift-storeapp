
//
//  BadgeListView.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class BadgeListView: UIStackView {
    
    override func addSubview(_ subview: UIView) {
        let constarint = self.subviews.last?.snp.trailing ?? self.snp.leading
        super.addSubview(subview)
        
        subview.snp.makeConstraints {
            $0.centerY.height.equalTo(self)
            $0.leading.equalTo(constarint).offset(2)
        }
    }
}

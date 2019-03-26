//
//  CustomCell.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class CustomCell : UITableViewCell {
    /// 이미지
    @IBOutlet weak var itemImageView: UIImageView!
    
    /// 타이틀
    @IBOutlet weak var title: UILabel!
    
    /// 상세설명
    @IBOutlet weak var itemDescription: UILabel!
    
    /// 메뉴 가격
    @IBOutlet weak var s_price: UILabel!
    
    /// 이벤트 배지
    @IBOutlet weak var delivery_type: UILabel!
    
}


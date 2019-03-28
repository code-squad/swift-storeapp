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
    
    @IBOutlet weak var labelStackView: UIStackView!
    
    @IBOutlet weak var customCellContentView: CustomCell!
    
    /// storeItem 객체를 받아서 cell에 반영
    func inputCellData(storeItem: StoreItem) {
        // 아이템 이미지 추출시도
        if let itemImage : UIImage = UIImage(named: storeItem.image) {
            // 성공시 이미지를 토대로 이미지뷰 추가
            self.itemImageView.image = itemImage
        } // 이미지 추출 실패시 공백뷰 생성
        else {
            self.itemImageView.backgroundColor = UIColor.blue
        }
    
        // storeItem 을 받아서 각 변수에 입력한다
        self.title.text = storeItem.title
        self.itemDescription.text  = storeItem.description
        self.s_price.text  = storeItem.s_price
        self.delivery_type.text = {
            var result = ""
            for text in storeItem.delivery_type {
                result.append(text)
                result += ","
            }
            result.removeLast()
            return result
        }()
    }
}


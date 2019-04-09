//
//  CustomCell.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class MyCustomCell : UITableViewCell {
    /// 이미지
    @IBOutlet weak var itemImageView: UIImageView!
    
    /// 타이틀
    @IBOutlet weak var title: UILabel!
    
    /// 상세설명
    @IBOutlet weak var itemDescription: UILabel!
    
    /// 메뉴 할인전 가격
    @IBOutlet weak var n_price: UILabel!
    
    /// 메뉴 가격
    @IBOutlet weak var s_price: UILabel!
    
    /// 이벤트 배지
    @IBOutlet weak var badgeStackView: UIStackView!
    
    
    
    /// 취소선 만드는 함수
    private func makeStrikeThrough(text: String) -> NSMutableAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    
    /// storeItem 객체를 받아서 cell에 반영
    func inputCellData(storeItem: StoreItem) {    
        // storeItem 을 받아서 각 변수에 입력한다
        self.title.text = storeItem.title
        self.itemDescription.text  = storeItem.description
        self.s_price.text  = storeItem.s_price
        
        // 딜리버리 타입 배열만큼 반복
        for badgeText in storeItem.badge {
            let badgeLable = UILabel()
            
            // 텍스트 입력
            badgeLable.text = badgeText
            
            // 스타일 적용
            badgeLable.backgroundColor = UIColor.purple
            badgeLable.textColor = UIColor.white
            
            // 배지 레이블 추가
            self.badgeStackView.addArrangedSubview(badgeLable)
            
            // 공백용 레이블 생성
            let blankLable = UILabel()
            blankLable.text = "  "
            // 추가
            self.badgeStackView.addArrangedSubview(blankLable)
        }
        
        // 할인전 가격에 스타일 적용
        self.n_price.attributedText = makeStrikeThrough(text: storeItem.n_price)
    }
    
    /// 셀의 배지 초기화
    func resetBadgeView(){
        self.badgeStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
}


//
//  MyScrollView.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 17..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os.log


class MyScrollView: UIScrollView {
    
    private var mainSubView = UIView()

    func setMainSubView(){
        self.mainSubView.frame = CGRect(x: 0, y: 0, width: 0, height: self.bounds.height)
        
        self.contentSize = self.bounds.size
        
        self.addSubview(self.mainSubView)
    }
    
    func add(image: UIImage){
        DispatchQueue.main.async {
            
            // 추가할 새 이미지뷰 생성. 사이즈는 스크롤뷰와 같음
            let newImageView = UIImageView(frame: self.frame)
            // 새 이미지 추출
            newImageView.image = image
            
            // 새 사진의 시작점은 메인서브뷰의 가로축 끝
            newImageView.frame.origin.x = self.mainSubView.frame.width
            
            // 새 메인서브뷰 가로길이 계산
            let newWidth = self.mainSubView.frame.width + self.bounds.width
            let newSize = CGSize(width: newWidth, height: self.bounds.height)
            let newFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: newSize)
            // 새 길이 적용
            self.contentSize = newSize
            self.mainSubView.frame = newFrame
            
            // 새이미지뷰 추가
            self.mainSubView.addSubview(newImageView)
            
            os_log("스크롤뷰에 이미지 추가 완료")
        }
        
    }
}

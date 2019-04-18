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
    
    func add(image: UIImage){
        // 사진을 동기로 추가
        DispatchQueue.main.async {
            // 추가할 새 이미지뷰 생성. 사이즈는 스크롤뷰 프레임과 같음
            let newImageView = UIImageView(frame: self.frame)
            // 새 이미지 적용
            newImageView.image = image
            
            // 새 사진의 시작점은 메인서브뷰의 가로축 끝. 스크롤바가 미리 추가되므로 -1 를 해준다.
            newImageView.frame.origin.x = self.frame.width * CGFloat(self.subviews.count - 1)
            
            // 새 컨텐츠 가로길이 계산
            let newWidth = self.contentSize.width + self.bounds.width
            // 새 컨텐츠 사이즈 계산
            let newSize = CGSize(width: newWidth, height: self.bounds.height)
            // 새 사이즈 적용
            self.contentSize = newSize
            
            // 새이미지뷰 추가
            self.addSubview(newImageView)
            
            os_log("스크롤뷰에 이미지 추가 완료")
        }
    }
}

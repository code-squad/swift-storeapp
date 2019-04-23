//
//  MyMainScrollView.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 23..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class MyMainScrollView: UIScrollView {    
    /// 뷰를 받아서 비율유지하면서 가로를 자신길이에 맞춘다
    private func resize(addedView: UIView) -> CGSize {
        // 결과용 사이즈 선언
        var resultSize = CGSize()
        
        // 비율 측정
        let ratioFromAddedView = addedView.frame.height / addedView.frame.width
        
        // 가로 설정
        resultSize.width = self.frame.width
        
        // 비율에 맞춰서 세로 설정
        resultSize.height = self.frame.width * ratioFromAddedView
        
        // 결과리턴
        return resultSize
    }

    /// 뷰를 받아서 해당 뷰 사이즈만큼 컨텐트 높이를 늘리고 입력뷰 사이즈 조절 후 마지막 뷰 밑에 위치시킨다
    func get(addedView: UIView){
        // 추가뷰 프레임 사이즈 수정
        addedView.frame.size = resize(addedView: addedView)
        
        // 마지막 서브뷰의 바텀 선언
        var lastViewBottomValue = CGPoint(x: 0, y: 0)
        
        // 마지막 뷰 추출. 없으면 패스
        if let lastView = self.subviews.last {
            // 오리진을 적용
            lastViewBottomValue.y = lastView.frame.origin.y
            
            // 높이를 추가해서 밑단위치로 설정
            lastViewBottomValue.y += lastView.frame.height
        }
        
        // 추가뷰 y 좌표 수정
        addedView.frame.origin = lastViewBottomValue
        
        // 마지막 뷰 밑에 추가
        self.addSubview(addedView)
        
        // 컨텐트 높이 증가
        self.contentSize.height += addedView.frame.height
    }
}

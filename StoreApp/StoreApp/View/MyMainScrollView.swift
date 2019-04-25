//
//  MyMainScrollView.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 23..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os.log

class MyMainScrollView: UIScrollView {
    /// 뷰를 받아서 비율유지하면서 가로를 self 길이에 맞춘다
    private func fitSize(targetView: UIView) -> CGSize {
        // 결과용 사이즈 선언
        var resultSize = CGSize()
        
        // 비율 측정
        let ratioFromAddedView = targetView.frame.height / targetView.frame.width
        
        // 가로 설정
        resultSize.width = self.frame.width
        
        // 비율에 맞춰서 세로 설정
        resultSize.height = self.frame.width * ratioFromAddedView
        
        // 결과 적용
        return resultSize
    }
    
    /// 뷰를 받아서 오리진 위치를 마지막 서브뷰 밑으로 이동시킨다
    private func fitOrigin(targetView: UIView) -> CGPoint {
        // 마지막 서브뷰의 바텀 선언
        var lastViewBottomValue = CGPoint(x: 0, y: 0)
        
        lastViewBottomValue.y += self.contentSize.height
        
        // 추가뷰 y 좌표 수정
        return lastViewBottomValue
    }

    /// 뷰를 추가하기 전 사전 작업
    private func beforeAdd(targetView: UIView){
        // 추가뷰 프레임 사이즈 수정
        targetView.frame.size = fitSize(targetView: targetView)
        
        // 추가되는 뷰의 오리진을 마지막 서브뷰 밑라인으로 이동시킨다
        targetView.frame.origin = fitOrigin(targetView: targetView)
        
        // 컨텐트 높이 증가
        self.contentSize.height += targetView.frame.height
    }
    
    /// 뷰를 받아서 해당 뷰 사이즈만큼 컨텐트 높이를 늘리고 입력뷰 사이즈 조절 후 마지막 뷰 밑에 위치시킨다
    func add(targetView: UIView){
        // 추가전 작업진행
        beforeAdd(targetView: targetView)
        
        // 마지막 뷰 밑에 추가
        super.addSubview(targetView)
        
        // 로깅
        os_log("섹션이미지 추가 완료")
    }
    
    /// 스토리보드로 추가한 뷰에 맞춰서 컨텐트 사이즈를 늘린다
    func setContentHeight(detailViewContoller: StoreItemDetailViewController){
        self.contentSize.height += detailViewContoller.detailView.frame.maxY
    }
}

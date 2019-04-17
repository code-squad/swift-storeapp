//
//  StoreItemDetailViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 16..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os.log
import MyURLDataMaker

class StoreItemDetailViewController: UIViewController {
    @IBOutlet weak var detailView: StoreItemDetailView!
    
    // 세그를 통해 넘어오는 값
    var detailHash = ""
    var detailTitle = ""
    
    /// 데이터를 받아서 아이템디테일 모델을 생성하는 함수를 사용, 생성한다.
    func makeItemDetail(data: Data){
        // 디테일모델 생성
        guard let storeItemdetailModel = StoreItemDetailMaker.makeStoreItemDetailModel(anyData: data) else {
            os_log("디테일모델 작성 실패")
            return ()
        }
        // title 설정
        storeItemdetailModel.set(title: self.detailTitle)
        // 모델을 생성해서 뷰에 적용시켜준다
        detailView.setting(model: storeItemdetailModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
        while true {
            let urlLoading = MyDetailDataLoader.makeDetailModel(detailHash: self.detailHash, completion: makeItemDetail)
            // 성공하면 불러오기 종료
            if urlLoading == true {
                break
            }
        }
        
        // end of viewDidLoad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

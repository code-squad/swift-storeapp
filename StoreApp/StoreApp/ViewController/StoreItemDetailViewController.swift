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
    @IBOutlet weak var thumbScrollView: UIScrollView!
    
    
    // 세그를 통해 넘어오는 값
    var detailHash = ""
    var detailTitle = ""
    
    /// 데이터를 받아서 아이템디테일 모델을 생성하는 함수를 사용, 생성한다.
    private func makeItemDetail(data: Data){
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
    
    /// url 점속 실패시 성공할때까지 반복
    private func tryConnectData(detailHash: String){
        // 실행 완료를 기다리지 않도록 디스패치 사용
        DispatchQueue.global().sync {
            // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
            let urlLoading = MyDetailDataLoader.detailModelData(detailHash: self.detailHash, completion: makeItemDetail)
            // 실패하면 다시 시도
            if urlLoading == false {
                tryConnectData(detailHash: detailHash)
            }
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
        tryConnectData(detailHash: self.detailHash)
        
        // end of viewDidLoad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

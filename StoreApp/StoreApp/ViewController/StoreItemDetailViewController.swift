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
    /// 이미지 스크롤뷰
    @IBOutlet weak var myScrollView: MyScrollView!
    
    @IBOutlet weak var detailSections: UIView!
    
    
    /// 파일저장객체
    let imageMaker = MyImageMaker()
    
    /// 디테일모델
    var detailModel = StoreItemDetailModel()
    
    /// 커스텀 디스패치큐 생성
    let customSerialQueue = DispatchQueue(label: "customDispatch", qos: .default)
    
    
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
        // 모델 설정
        self.detailModel = storeItemdetailModel
        // 모델을 생성해서 뷰에 적용시켜준다
        detailView.setting(model: storeItemdetailModel)
        os_log("모델 데이터 적용 완료")
        
        // 데이터가 추가되면 이미지를 추가한다
        self.imageMaker.saveFiles(urls: self.detailModel.thumb_images, completion: add)
    }
    
    /// url 점속 실패시 성공할때까지 반복
    private func tryConnectData(detailHash: String){
        // 실행 완료를 기다리지 않도록 디스패치 사용
        customSerialQueue.sync {
            // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
            let urlLoading = MyDetailDataLoader.detailModelData(detailHash: self.detailHash, completion: makeItemDetail)
            // 실패하면 다시 시도
            if urlLoading == false {
                tryConnectData(detailHash: detailHash)
            }
        }        
    }
    
    /// 풀패스를 받아서 이미지를 추출
    func imageFrom(imageFullPath: String) -> UIImage? {
        return UIImage(contentsOfFile: imageFullPath)
    }
    
    /// 이미지풀패스 를 받아서 스크롤뷰에 추가
    func add(imageFullPath: String){
        // 이미지를 파일에서 추출시도
        guard let loadedImage = imageFrom(imageFullPath: imageFullPath) else {
            // 추출 실패시
            os_log("이미지 파일이 없습니다. : %@",imageFullPath)
            return ()
        }
        // 추출한 이미지를 스크롤뷰에 추가
        self.myScrollView.add(image: loadedImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
        tryConnectData(detailHash: self.detailHash)
        
        // 스크롤뷰 설정
        self.myScrollView.setMainSubView()
        
        
        
        // end of viewDidLoad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

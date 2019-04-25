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
    
    @IBOutlet weak var myMainScrollView: MyMainScrollView!
    
    
    /// 파일저장객체
    private let imageMaker = MyImageMaker()
    
    /// 디테일모델
    private var detailModel = StoreItemDetailModel()
    
    /// 커스텀 디스패치큐 생성
    private let customSerialQueue = DispatchQueue(label: "customDispatch", qos: .default)
    
    /// 네트워크 담당객체
    private let detailMaker = StoreItemDetailMaker()
    
    /// 델리게이트패턴 구현
    private var sendOrderDetail : SendOrderDetailDelegate?
    
    
    /// 세그를 통해 넘어오는 값
    private var detailHash = ""
    private var detailTitle = ""
    
    /// 주문하기 버튼 액션
    @IBAction func orderAction(_ sender: Any) {
        // 주문결과 객체 생성
        let orderResult = OrderResult(customerName: "Drake", price: self.detailView.n_price.text! , menu: self.detailTitle)
        
        // 주문결과를 post
        self.sendOrderDetail?.SendOrderDetail(orderResult: orderResult)
        
        // 주문완료되면 뷰컨을 닫는다
        navigationController?.popViewController(animated: true)        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /// 데이터를 받아서 아이템디테일 모델을 생성하는 함수를 사용, 생성한다.
    private func makeItemDetail(data: Data){
        // 디테일모델 생성
        guard let storeItemdetailModel = self.detailMaker.makeStoreItemDetailModel(anyData: data) else {
            os_log("디테일모델 작성 실패")
            return ()
        }
        // title 설정
        storeItemdetailModel.set(title: self.detailTitle)
        // 모델 설정
        self.detailModel = storeItemdetailModel
        
        DispatchQueue.main.async {
            self.detailView.adCopy.text = self.detailModel.product_description
            self.detailView.point.text = self.detailModel.point
            self.detailView.delivery_price.text = self.detailModel.delivery_fee
            self.detailView.title.text = self.detailModel.title
            self.detailView.n_price.text = self.detailModel.n_price
            self.detailView.s_price.attributedText = MyStyleMaker.makeStrikeThrough(text: self.detailModel.s_price)
            os_log("상세모델 데이터 적용 완료")
        }
        
        // 데이터가 추가되면 이미지를 추가한다
        self.imageMaker.saveFiles(urls: self.detailModel.thumb_images, completion: add)
        
        // 섹션 이미지도 추가한다
        self.imageMaker.saveFiles(urls: self.detailModel.detail_section, completion: addSectionImage)
        
    }
    
    /// url 점속 실패시 성공할때까지 반복
    private func tryConnectData(detailHash: String){
        // 실행 완료를 기다리지 않도록 디스패치 사용
        customSerialQueue.sync {
            // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
            let urlLoading = MyDetailDataLoader.detailModelData(detailHash: self.detailHash,completion: makeItemDetail)
            // 실패하면 다시 시도
            if urlLoading == false {
                tryConnectData(detailHash: detailHash)
            }
        }        
    }
    
    /// 풀패스를 받아서 이미지를 추출
    private func imageFrom(imageFullPath: String) -> UIImage? {
        guard let result = UIImage(contentsOfFile: imageFullPath) else {
            // 추출 실패시
            os_log("이미지 파일이 없습니다. : %@",imageFullPath)
            return nil
        }
        return result
    }
    
    /// 이미지풀패스 를 받아서 스크롤뷰에 추가
    private func add(imageFullPath: String){
        // 이미지를 파일에서 추출시도
        guard let loadedImage = imageFrom(imageFullPath: imageFullPath) else {
            return ()
        }
        // 추출한 이미지를 스크롤뷰에 추가
        self.myScrollView.add(image: loadedImage)
    }
    
    /// 섹션 추가 함수
    private func addSectionImage(fullPath: String){
        // 이미지 추출시도
        guard let loadedImage = imageFrom(imageFullPath: fullPath) else {
            return ()
        }
        
        DispatchQueue.main.sync {
            // 추출된 이미지로 이미지뷰 생성
            let newImageView = UIImageView(image: loadedImage)
            
            // 메인스크롤뷰에 추가
            self.myMainScrollView.add(targetView: newImageView)
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // 메인스크롤뷰의 컨텐트를 늘린다
        self.myMainScrollView.setContentHeight(targetView: self.detailView)
        
        // 전달받은 디테일해쉬를 디코드. 실패할경우 계속 시도한다
        tryConnectData(detailHash: self.detailHash)
        
        // end of viewDidLoad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


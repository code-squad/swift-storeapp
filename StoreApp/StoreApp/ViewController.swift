//
//  ViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {
    /// 테이블뷰
    @IBOutlet weak var storeItemTableView: UITableView!
    
    /// 데이터소스
    private let dataSourceObject = DataSourceObject()
    
    /// 전체 json 파일명 목록
    private let allJSONFileName = ["main","soup","side"]
    
    /// 헤더 상세내용
    private let allHeaderTitle = ["메인반찬","국.찌게","밑반찬"]
    private let allHedaerText = ["한그릇 뚝딱 메인 요리","김이 모락모락 국.찌게","언제 먹어도 든든한 밑반찬"]
    
    /// 커스텀헤더 파일명
    private let nibFileName = "MyCustomHeader"
    
    /// json 데이터 URL
    private let jsonURLList : [String] = ["https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main","https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup","https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/course"]
    
//    let mainURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main"
//    let gookURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup"
//    let mitURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/course"
    
    
    
    /// 헤더컨텐트 매니저 데이터를 데이터소스에 입력한다
    func inputHeaderContent(dataSourceObject: DataSourceObject){
        // 헤더컨텐트 매니저 데이터 입력
        for count in 0..<allHeaderTitle.count {
            let myHeaderContent = MyHeaderContent(title: allHeaderTitle[count], text: allHedaerText[count])
            dataSourceObject.addHeaderContent(myHeaderContent: myHeaderContent)
        }
    }
    
//    /// JSONData 배열을 받아서 입력받은 데이터소스에 스토어아이템으로 변환시켜서 넣는다
//    func inputDataList(JSONDataList: [Data], dataSourceObject: DataSourceObject) {
//        for jsonData in JSONDataList {
//
//            inputData(JSONData: jsonData, dataSourceObject: dataSourceObject)
//        }
//    }
    
    /// JSON data 받아서 Data 형태로 치환한다
    func inputData(JSONData: Data, dataSourceObject: DataSourceObject, index: Int){
        // JSONData를 스토어아이템 배열로 치환
        let storeItemList = StoreItemMaker.makeStoreItemList(jsonData: JSONData)
        
        // 슬롯으로 생성        
        let storeItemSlot = StoreItemSlot(storeItemList: storeItemList)
        
        // 데이터소스에 추가
        dataSourceObject.inputData(storeItemSlot: storeItemSlot, index: index)
        
        // 로깅을 위한 정수형 -> 문자형 변환
        let indexString : String = String(index)
        os_log("데이터소스에 슬롯추가완료. index : %@",indexString)
    }
    
//    /// 스토어 정보를 데이터소스에 입력한다
//    func inputStoreItemData(dataSourceObject: DataSourceObject){
//        // JSON 에서 파일명 추출
//        for fileName in self.allJSONFileName {
//            // 파일명으로 스토어아이템 슬롯 추출
//            let storeItemSlot = StoreItemMaker.makeStoreItem(fileName: fileName)
//            // 스토어아이템 데이터 추가
//            dataSourceObject.inputData(storeItemSlot: storeItemSlot)
//        }
//    }
    
    /// 테이블뷰에 커스텀 헤더 등록
    func inputCustomHeader(tableView: UITableView){
        let headerNib = UINib.init(nibName: nibFileName, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: nibFileName)
    }
    
    /// URL 배열을 받아서 Data 배열로 리턴
    func makeDataListFrom(unCheckedURLList: [String], dataSourceObject: DataSourceObject) {
        
        // url 카운트 만큼 미리 빈 슬롯을 추가해준다
        for _ in 0..<self.jsonURLList.count {
            dataSourceObject.addEmptyStoreItemSlot()
        }
        
        for count in 0..<self.jsonURLList.count {
            // 데이터 추출 성공시 결과변수에 추가
            dataFrom(unCheckedURL: self.jsonURLList[count], dataSourceObject: dataSourceObject, index: count)
        }
    }
    
    /// url 을 받아서 데이터 리턴
    private func dataFrom(unCheckedURL: String, dataSourceObject: DataSourceObject, index: Int){
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "\(unCheckedURL)") else {
            os_log("잘못된 URL 입니다.")
            return
        }
        
        // Request
        let request = URLRequest(url: url)
        
        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // getting Data Error
            guard error == nil else {
                os_log("url 접속실패")
                return
            }
            
            if let jsonData = data, let response = response as? HTTPURLResponse, response.statusCode == 200   {
                
                self.inputData(JSONData: jsonData, dataSourceObject: dataSourceObject, index: index)
                
            }
            
        }
        dataTask.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 헤더컨텐트 매니저 데이터 입력
        inputHeaderContent(dataSourceObject: self.dataSourceObject)
        
        // 테이블뷰에 데이터소스 입력
//        self.storeItemTableView.dataSource = self.dataSourceObject
        makeDataListFrom(unCheckedURLList: self.jsonURLList, dataSourceObject: self.dataSourceObject)
//        inputDataList(JSONDataList: jsonDataList, dataSourceObject: self.dataSourceObject)
        
        /// 스토어 정보를 데이터소스에 입력한다
//        inputStoreItemData(dataSourceObject: self.dataSourceObject)
        
        // 테이블뷰에 커스텀 헤더 등록
        inputCustomHeader(tableView: self.storeItemTableView)
        
        // 테이블뷰에 델리게이트 입력
        self.storeItemTableView.delegate = self.dataSourceObject
        
        // end of viewDidLoad
    }
    
    
}


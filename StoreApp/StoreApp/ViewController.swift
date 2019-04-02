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
    func inputHeaderContent(){
        // 헤더컨텐트 매니저 데이터 입력
        for count in 0..<allHeaderTitle.count {
            let myHeaderContent = MyHeaderContent(title: allHeaderTitle[count], text: allHedaerText[count])
            self.dataSourceObject.addHeaderContent(myHeaderContent: myHeaderContent)
        }
    }
    
    /// 스토어 정보를 데이터소스에 입력한다
    func inputStoreItemData(){
        // JSON 에서 파일명 추출
        for fileName in self.allJSONFileName {
            // 파일명으로 스토어아이템 슬롯 추출
            let storeItemSlot = StoreItemMaker.makeStoreItem(fileName: fileName)
            // 스토어아이템 데이터 추가
            self.dataSourceObject.inputData(storeItemSlot: storeItemSlot)
        }
    }
    
    /// 테이블뷰에 커스텀 헤더 등록
    func inputCustomHeader(){
        let headerNib = UINib.init(nibName: nibFileName, bundle: Bundle.main)
        self.storeItemTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: nibFileName)
    }
    
    /// url 을 받아서 데이터 리턴
    
    private func dataFrom(unCheckedURL: String) -> Data? {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "\(unCheckedURL)") else {
            os_log("잘못된 URL 입니다.")
            return nil
        }
        
        // Request
        let request = URLRequest(url: url)
        
        // 결과 리턴용
        var resultData : Data? = nil
        
        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            guard let jsonData = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else  {
                return ()
            }
                resultData = jsonData
        }
        dataTask.resume()
        return resultData
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // 헤더컨텐트 매니저 데이터 입력
        inputHeaderContent()
        
        // 테이블뷰에 데이터소스 입력
        self.storeItemTableView.dataSource = self.dataSourceObject
        
        /// 스토어 정보를 데이터소스에 입력한다
        inputStoreItemData()
        
        // 테이블뷰에 커스텀 헤더 등록
        inputCustomHeader()
        
        // 테이블뷰에 델리게이트 입력
        self.storeItemTableView.delegate = self.dataSourceObject
        
        // end of viewDidLoad
    }
    
    
}


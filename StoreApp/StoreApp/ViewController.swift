//
//  ViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

/// 노티 이름 선언
extension Notification.Name {
    static let didAddStoreItemSlot = Notification.Name("didAddStoreItemSlot")
}

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

    /// 헤더컨텐트 매니저 데이터를 데이터소스에 입력한다
    func inputHeaderContent(dataSourceObject: DataSourceObject){
        // 헤더컨텐트 매니저 데이터 입력
        for count in 0..<allHeaderTitle.count {
            let myHeaderContent = MyHeaderContent(title: allHeaderTitle[count], text: allHedaerText[count])
            dataSourceObject.addHeaderContent(myHeaderContent: myHeaderContent)
        }
    }
    
    /// 테이블뷰에 커스텀 헤더 등록
    func inputCustomHeader(tableView: UITableView){
        let headerNib = UINib.init(nibName: nibFileName, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: nibFileName)
    }
    
    /// 노티 생성 함수
    func makeNoti(){
        // 스토어아이템 추가시 노티
        NotificationCenter.default.addObserver(self, selector: #selector(afterSlotAdded(notification:)), name: .didAddStoreItemSlot, object: nil)
    }
    
    /// 슬롯추가됨 노티 포스트시 리로드 실행
    @objc func afterSlotAdded(notification: Notification){
        os_log("슬롯추가됨 노티발생")
        
        // 인덱스를 받아서 해당 섹션 리로드
        if let index = notification.object as? Int {
            // 로깅을 위한 형변환
            let indexString = String(index)
            os_log("노티 후 섹션 %@ 리로드 시도",indexString)
            
            // 섹션 리로드
            self.storeItemTableView.reloadSections(IndexSet(integer: index), with: .top)
            
            os_log("노티 후 섹션 %@ 리로드 성공",indexString)
        } // 인덱스가 없으면 작동안함
        else {
            os_log("슬롯추가 노티에서 인덱스 추출실패")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 노티 옵저버 생성
        makeNoti()
        
        // 헤더컨텐트 매니저 데이터 입력
        inputHeaderContent(dataSourceObject: self.dataSourceObject)
        
        // 테이블뷰에 데이터소스 입력
        self.storeItemTableView.dataSource = self.dataSourceObject
        
        // 데이터소스 내부 값 입력
        URLWorker.makeDataListFrom(unCheckedURLList: self.jsonURLList, dataSourceObject: self.dataSourceObject)
        
        // 테이블뷰에 커스텀 헤더 등록
        inputCustomHeader(tableView: self.storeItemTableView)
        
        // 테이블뷰에 델리게이트 입력
        self.storeItemTableView.delegate = self.dataSourceObject
        
        // end of viewDidLoad
    }
    
    
}


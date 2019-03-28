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
    
    /// 헤더컨텐트매니저
    private let headerContentmanager = MyHeaderContentManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 헤더컨텐트 매니서 데이터 입력
        for count in 0..<allHeaderTitle.count {
            let myHeaderContent = MyHeaderContent(title: allHeaderTitle[count], text: allHedaerText[count])
            self.headerContentmanager.addContect(myHeaderContent: myHeaderContent)
        }
        
        // 테이블뷰에 데이터소스 입력
        self.storeItemTableView.dataSource = self.dataSourceObject
        
        // 테이블뷰에 데이터소스 입력
        for fileName in self.allJSONFileName {
            let storeItemSlot = StoreItemMaker.makeStoreItem(fileName: fileName)
            // 데이터 추가
            self.dataSourceObject.inputData(storeItemSlot: storeItemSlot)
        }
        
        // 테이블뷰에 커스텀 헤더 등록
        let headerNib = UINib.init(nibName: "MyCustomHeader", bundle: Bundle.main)
        self.storeItemTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MyCustomHeader")
        
        // 델리게이트에 헤드컨텐트 입력
        self.dataSourceObject.headContentManager = self.headerContentmanager
        
        // 테이블뷰에 델리게이트 입력
        self.storeItemTableView.delegate = self.dataSourceObject
        
        // end of viewDidLoad
    }
    
    
}


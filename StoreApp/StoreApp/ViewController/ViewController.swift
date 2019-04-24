//
//  ViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os.log
import MyURLDataMaker

/// 노티 이름 선언
extension Notification.Name {
    static let didAddStoreItemSlot = Notification.Name("didAddStoreItemSlot")
    static let didDownloadImageFile = Notification.Name("didDownloadImageFile")
}

/// 디테일뷰컨의 주문완료 함수 구현을 위한 델리게이트
protocol SendOrderDetailDelegate {
    func SendOrderDetail(orderResult: OrderResult)
}


class ViewController: UIViewController, SendOrderDetailDelegate {
    /// 테이블뷰
    @IBOutlet weak var storeItemTableView: UITableView!
    
    /// MyURLDataMaker 내부객체 선언
    let myDataLoader = MyDataLoader()
    
    /// 커스텀 디스패치큐 생성
    let customSerialQueue = DispatchQueue(label: "customSerial", qos: .default)
    
    /// 데이터소스
    private let dataSourceObject = DataSourceObject()
    
    /// 헤더 상세내용
    private let allHeaderTitle = ["메인반찬","국.찌게","밑반찬"]
    private let allHedaerText = ["한그릇 뚝딱 메인 요리","김이 모락모락 국.찌게","언제 먹어도 든든한 밑반찬"]
    
    /// 커스텀헤더 파일명
    private let nibFileName = "MyCustomHeader"
    
    /// 이미지메이커
    private let myImageMaker = MyImageMaker()
    
    
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
    func makeNotificationObserver(){
        // 스토어아이템 추가시 노티
        NotificationCenter.default.addObserver(self, selector: #selector(afterSlotAdded(notification:)), name: .didAddStoreItemSlot, object: nil)
        // 이미지파일 다운로드 완료시 노티
        NotificationCenter.default.addObserver(self, selector: #selector(afterDownloadImageFile(notification:)), name: .didDownloadImageFile , object: nil)
    }
    
    /// 이미지파일 다운 완료시 이미지 파일을 셀에 적용
    @objc func afterDownloadImageFile(notification: Notification){
        guard
            let fileName = notification.userInfo?["fileName"] as? String,
            let section = notification.userInfo?["section"] as? Int,
            let row = notification.userInfo?["row"] as? Int else {
                os_log("이미지 다운 노티 유저인포 잘못됨")
                return ()
        }
        
        os_log("이미지 다운로드 완료 노티를 받음")

        // 데이터소스 셀에 이미지파일주소 를 넣는다
        self.dataSourceObject.set(imageFileURL: fileName, section: section, row: row)
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: row, section: section)
            self.storeItemTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    /// 슬롯추가됨 노티 포스트시 리로드 실행
    @objc func afterSlotAdded(notification: Notification){
        os_log("슬롯추가됨 노티발생")
        
        // 인덱스를 받아서 해당 섹션 리로드
        guard let index = notification.object as? Int else  {
            // 인덱스가 없으면 작동안함
            os_log("슬롯추가 노티에서 인덱스 추출실패")
            return ()
        }
        
        // 로깅을 위한 형변환
        let indexString = String(index)
        os_log("노티 후 섹션 %@ 리로드 시도",indexString)
        
        DispatchQueue.main.sync {
            // 섹션 리로드
            self.storeItemTableView.reloadSections(IndexSet(integer: index), with: .top)
            os_log("노티 후 섹션 %@ 리로드 성공",indexString)
        }
    }
    
    /// 다운로드 실패시 탈출 클로저
    func didFailDownload(imageURL: String, section: Int, row: Int){
        self.myImageMaker.save(imageURL: imageURL, section: section, row: row, completion: didFailDownload)
    }
    
    /// 데이터를 받아서 데이터소스에 입력하고 섹션을 리로드 한다. 비동기.
    func toDataSourceAdd(data: Data, index: Int){
        // 커스텀 동기 시작
        self.customSerialQueue.sync {
            // 받은 데이터를 스토어아이템 배열로 변형
            let storeItems = StoreItemMaker.makeStoreItemList(jsonData: data)
            
            // 스토어아이템배열을 데이터소스에 추가
            self.dataSourceObject.inputData(storeItemSlot: storeItems, index: index)
            
            // 리로드 완료를 체크
            self.myImageMaker.getURLs(section: index,
                                      urls: self.dataSourceObject.itemImageURLs(section: index))
            
            // 모든 섹션 데이터주입이 완료됬는지 체크
            if self.dataSourceObject.isAllSectionAdded() {
                // 모든 섹션이 완료되면 이미지 다운로드를 시작한다
                self.myImageMaker.saveAllURL(completion: didFailDownload)
            }
        }        
    }
    
    /// URL list, 데이터소스, data add 함수를 넣어서 url 에서 data 를 데이터소스에 넣는다
    func dataSourceDataFrom(url: String, index: Int){
        // url 리스트에 연결 시도
        if self.myDataLoader.dataFrom(unCheckedURL: self.myDataLoader.jsonURLList[index],
                                      index: index,
                                      completion: toDataSourceAdd) {
            // 연결 성공
            os_log("URL Session 연결 성공")
        } // 연결 실패
        else {
            os_log("URL Session 연결 실패")
        }
    }
    
    /// URL list, 데이터소스, data add 함수를 넣어서 url 에서 data 를 데이터소스에 넣는다
    func dataSourceDataListFrom(urlList: [String]){
        // url 리스트 카운팅
        for count in 0..<urlList.count {
            // url 리스트에 연결 시도
            dataSourceDataFrom(url: urlList[count], index: count)
        }
    }
    
    /// 셀이 선택되서 디테일뷰로 넘어가는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 세그 확인
        if segue.identifier == "showDetail" {
            // 도착지의 뷰컨 클래스 확인
            guard let storeItemDetailViewController = segue.destination as? StoreItemDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            // 선택된 뷰가 셀인지 체크
            guard let selectedCell = sender as? MyCustomCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            // 셀에서 인덱스 패스 추출
            guard let indexPath = self.storeItemTableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            // 값을 넘겨준다.
            let detailHash = self.dataSourceObject.detailHash(indexPath: indexPath)
            storeItemDetailViewController.detailHash = detailHash
            let detailTitle = self.dataSourceObject.title(indexPath: indexPath)
            storeItemDetailViewController.detailTitle = detailTitle
            
            // 델리게이트 패턴 적용
            storeItemDetailViewController.sendOrderDetail = self
            
            
        } // segue 확인 실패시
        else {
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    func SendOrderDetail(orderResult: OrderResult){
        StoreItemMaker.post(orderResult: orderResult)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 노티 옵저버 생성
        makeNotificationObserver()
        
        // 헤더컨텐트 매니저 데이터 입력
        inputHeaderContent(dataSourceObject: self.dataSourceObject)
        
        // 테이블뷰에 데이터소스 입력
        self.storeItemTableView.dataSource = self.dataSourceObject
        
        // json 리스트만큼 섹션 추가
        self.dataSourceObject.addEmptyStoreItemSlot(count: self.myDataLoader.jsonURLList.count)
        
        // 이미지메이커 초기세팅
        self.myImageMaker.setMaxSectionCount(count: self.myDataLoader.jsonURLList.count)
        
        // url 에서 데이터소스 데이터 추출
        dataSourceDataListFrom(urlList: self.myDataLoader.jsonURLList)
        
        // 테이블뷰에 커스텀 헤더 등록
        inputCustomHeader(tableView: self.storeItemTableView)
        
        // 테이블뷰에 델리게이트 입력
        self.storeItemTableView.delegate = self.dataSourceObject
        
        
        // end of viewDidLoad
    }
    
    
}


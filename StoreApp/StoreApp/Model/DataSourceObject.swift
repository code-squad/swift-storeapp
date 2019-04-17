//
//  DataSourceObject.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import Toaster


class DataSourceObject : NSObject, UITableViewDataSource  {
    private let defaultCellIdentifier : String = "MyCustomCell"
    
    /// 헤더컨텐트를 받는다
    private var headContentManager = MyHeaderContentManager()
    
    /// 스토어아이템 맥스 카운트를 저장한다
   private  var storeItemContainer : StoreItemContainer = StoreItemContainer()
    
    override init(){}
    init(storeItemContainer: StoreItemContainer){
        self.storeItemContainer = storeItemContainer
    }
    
    /// 헤더컨텐트를 받아서 매니저에 추가
    func addHeaderContent(myHeaderContent: MyHeaderContent){
        self.headContentManager.add(myHeaderContent: myHeaderContent)
    }
    
    /// 데이터소스에 데이터 입력
    func inputData(storeItemSlot: StoreItemSlot){
        self.storeItemContainer.add(storeItemSlot: storeItemSlot)
    }
    
    /// 데이터소스 인덱스에 스토어아이템 배열 추가
    func inputData(storeItemSlot: [StoreItem], index: Int){
        self.storeItemContainer.add(storeItemList: storeItemSlot, index: index)
    }
    
    /// 센션당 로우 카운트 리턴
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeItemContainer.count(index: section)
    }
    
    /// 셀 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath) as! MyCustomCell
        
        cell.resetBadgeView()
        
        let storeItem = self.storeItemContainer.storeItem(indexPath: indexPath)
        
        
        //storeItem 을 받아서 각 변수에 입력한다
        cell.inputCellData(storeItem: storeItem)
        
        cell.setImage(imageFileURL: storeItem.imageFileURL)
        
        return cell
    }
    
    /// 세션 카운트 리턴
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.storeItemContainer.count()
    }
    
    /// 비어있는 슬롯을 만든다
    func addEmptyStoreItemSlot(){
        self.storeItemContainer.makeEmptyItemSlot()
    }
    
    /// 비어있는 슬롯을 입력값 개수만큼 만든다
    func addEmptyStoreItemSlot(count: Int){
        for _ in 0..<count {
            self.storeItemContainer.makeEmptyItemSlot()            
        }
    }
    
    /// 섹션인덱스, 로우인덱스를 받아서 해당 커스텀셀을 넘긴다
    private func storeItem(section: Int, row: Int) -> StoreItem {
        return self.storeItemContainer.storeItem(section: section, row: row)
    }
    
    /// 섹션인덱스, 로우인덱스를 받아서 해당 셀의 이미지 주소를 넘긴다
    func itemImageURL(section: Int, row: Int) -> String {
        let storeItem = self.storeItem(section: section, row: row)
        return storeItem.image
    }
    
    /// 섹션인덱스를 받아서 해당 섹션의 모든 셀의 이미지url 울 배열로 리턴한다
    func itemImageURLs(section: Int) -> [String] {
        // 이미지url 배열
        var result: [String] = []
        
        // 해당 섹션의 모든 로우가 대상
        for count in 0..<self.storeItemContainer.count(index: section) {
            let url = itemImageURL(section: section, row: count)
            result.append(url)
        }
        
        return result
    }
    
    /// 이미지, 섹션인덱스, 로우넘버를 받아서 해당 셀의 이미지파일주소 입력
    func set(imageFileURL: String, section: Int, row: Int){
        // 해당 아이템 추출
        let storeItem = self.storeItem(section: section, row: row)
        
        // 이미지파일주소 입력
        storeItem.imageFileURL = imageFileURL
    }
    
    /// 모든 섹션 로우 입력이 완료됬는지 체크
    func isAllSectionAdded() -> Bool{
        // 모든 섹션이 대상
        for count in 0..<self.storeItemContainer.count() {
            // 섹션이 하나라도 로우가 0이면 거짓 리턴
            if self.storeItemContainer.count(index: count) == 0 {
                return false
            }
        }
        // 모든 섹션 체크가 끝나면 리턴
        return true
    }
    
    /// 인덱스패스를 받아서 해당 셀의 detail_hash 를 리턴한다
    func detailHash(indexPath: IndexPath) -> String {
        let detailhash = self.storeItemContainer.storeItem(indexPath: indexPath).detail_hash
        return detailhash
    }
    
    /// 인덱스패스를 받아서 해당 셀의 title 리턴한다
    func title(indexPath: IndexPath) -> String {
        let title = self.storeItemContainer.storeItem(indexPath: indexPath).title
        return title
    }
    
}

/// 델리게이트 기능 확장
extension   DataSourceObject : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyCustomHeader") as! MyCustomHeader
        
        // 헤더컨텐트를 꺼낸다
        let headContent = self.headContentManager[section]
        
        headerView.headerTitle.text = headContent.title
        headerView.headerText.text = headContent.adCopy
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    /// 로우가 선택되면 타이틀 메뉴와 (할인된)최종 가격 정보를 toast 형태로 표시한다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 떠있는 토스트를 지운다
        ToastCenter.default.cancelAll()
        
        // 토스트에 들어갈 텍스트
        let toastText = self.storeItemContainer.toastMessage(indexPath: indexPath)
        
        // 토스트 메세지 생성
        let toastMessage = Toast(text: toastText, duration: Delay.short)
        
        // 토스트 메세지 출력
        toastMessage.show()
    }
}


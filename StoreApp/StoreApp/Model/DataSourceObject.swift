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
    
    /// 데이터소스 인덱스에 데이터 입력
    func inputData(storeItemSlot: StoreItemSlot, index: Int){
        self.storeItemContainer.add(storeItemSlot: storeItemSlot, index: index)
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


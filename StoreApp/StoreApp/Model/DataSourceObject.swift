//
//  DataSourceObject.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class DataSourceObject : NSObject, UITableViewDataSource  {
    private let defaultCellIdentifier : String = "MyCustomCell"
    
    
    /// 헤더컨텐트를 받는다
    var headContentManager = MyHeaderContentManager()
    
    /// 스토어아이템 맥스 카운트를 저장한다
    var storeItemContainer : StoreItemContainer = StoreItemContainer()
    
    override init(){}
    init(storeItemContainer: StoreItemContainer){
        self.storeItemContainer = storeItemContainer
    }
    
    /// 데이터소스에 데이터 입력
    func inputData(storeItemSlot: StoreItemSlot){
        self.storeItemContainer.addStoreItemSlot(storeItemSlot: storeItemSlot)
    }
    
    /// 센션당 로우 카운트 리턴
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeItemContainer.getCount(number: section)
    }
    
    /// 셀 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath) as! MyCustomCell
        
        let storeItem = self.storeItemContainer.getStoreItem(indexPath: indexPath)
        
        
        //storeItem 을 받아서 각 변수에 입력한다
        cell.inputCellData(storeItem: storeItem)
            
        return cell
    }
    
    /// 세션 카운트 리턴
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.storeItemContainer.count()
    }
    

}

extension   DataSourceObject : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyCustomHeader") as! MyCustomHeader
        
        // 헤더컨텐트를 꺼낸다
        let headContent = self.headContentManager.getMyHeaderContent(index: section)
        
        headerView.headerTitle.text = headContent.title
        headerView.headerText.text = headContent.text
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}


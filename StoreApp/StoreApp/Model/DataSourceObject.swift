//
//  DataSourceObject.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class DataSourceObject : NSObject, UITableViewDataSource {
    private let defaultCellIdentifier : String = "MyCustomCell"
    
    /// 스토어아이템 맥스 카운트를 저장한다
    var storeItemContainer : StoreItemContainer
    
    init(storeItemContainer: StoreItemContainer){
        self.storeItemContainer = storeItemContainer
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

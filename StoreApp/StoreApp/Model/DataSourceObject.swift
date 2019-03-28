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
    var storeItemManager : StoreItemManager
    
    init(storeItemManager: StoreItemManager){
        self.storeItemManager = storeItemManager
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeItemManager.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath) as! MyCustomCell
        
        let storeItem = self.storeItemManager.getStoreItem(index: indexPath.row)
        
        //storeItem 을 받아서 각 변수에 입력한다
        cell.inputCellData(storeItem: storeItem)
            
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

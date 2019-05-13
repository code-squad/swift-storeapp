//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 22..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class StoreItemManager {
    
    //MARK: - Properties
    private var storeItemManager = [StoreItems]()

    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItems? {
        guard 0 <= index, index < storeItemManager.count else { return nil }
        return storeItemManager[index]
    }
    
    //MARK: Initialization
    init(variousSectionInfo: [SectionInfo]) {
        for sectionInfo in variousSectionInfo {
            let storeItems = StoreItems(storeItemsInitInfo: sectionInfo)
            self.storeItemManager.append(storeItems)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(makeToPostReloadRow),
                                               name: .imageDidDownload,
                                               object: nil)
    }
    
    @objc func makeToPostReloadRow(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let imageName = userInfo[UserInfoKey.imageName] as? String else { return }
        for items in storeItemManager {
            guard let index = storeItemManager.firstIndex(where: {$0 === items}) else { return }
            items.postReloadRow(section: Int(index), imageName: imageName)
        }
    }
    
    //MARK: Instance
    func itemCount() -> Int {
        return storeItemManager.count
    }
    
    func index(of items: StoreItems) -> Int? {
        return storeItemManager.firstIndex(where: {$0 === items})
    }
}

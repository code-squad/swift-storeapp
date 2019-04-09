//
//  StoreItemContainer.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 28..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class StoreItemContainer {
    private var storeItemSlotList : [StoreItemSlot] = []
    
    init(){}
    
    
    /// 스토어아이템 슬롯을 받아서 추가한다
    func add(storeItemSlot: StoreItemSlot) {
        self.storeItemSlotList.append(storeItemSlot)
    }
    
    /// 스토어아이템 슬롯 번호를 받아서 count 를 리턴한다
    func count(index: Int) -> Int {
        return self.storeItemSlotList[index].count()
    }
    
    /// 인덱스패스를 받아서 해당 아이템을 리턴
    func storeItem(indexPath: IndexPath) -> StoreItem {
        return self.storeItemSlotList[indexPath.section].storeItem(index: indexPath.row)
    }
    
    /// 전체 스토어아이템 슬롯의 count 리턴
    func count() -> Int {
        return self.storeItemSlotList.count
    }
    
    /// 인덱스패스를 받아서 타이틀, 가격을 문자열로 리턴
    func toastMessage(indexPath: IndexPath) -> String {
        // 인덱스패스를 받아서 메세지 추출
        let message = self.storeItemSlotList[indexPath.section].toastMessage(index: indexPath.row)
        // 메세지 리턴
        return message
    }
    
    /// 헤더컨텐트 카운트를 받아서 비어있는 슬롯을 만든다
    func makeEmptyItemSlot(count: Int){
        for _ in 0..<count {
            self.storeItemSlotList.append(StoreItemSlot())
        }
    }
    
    /// 비어있는 슬롯을 만든다
    func makeEmptyItemSlot(){
        self.storeItemSlotList.append(StoreItemSlot())
    }
    
    /// 인덱스와 스토어아이템배열을 받아서 해당 인덱스에 추가해준다
    func add(storeItemList: [StoreItem], index: Int){
        self.storeItemSlotList[index].add(storeItemList: storeItemList, index: index)
    }
    
    /// 섹션인덱스, 로우인덱스를 받아서 해당 커스텀셀을 넘긴다
    func storeItem(section: Int, row: Int) -> StoreItem {
        return self.storeItemSlotList[section].storeItem(row: row)
    }
}

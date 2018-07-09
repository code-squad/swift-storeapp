//
//  StoreItem.swift
//  StoreApp
//
//  Created by rk on 2018. 7. 9..
//  Copyright © 2018년 fryb. All rights reserved.
//

import Foundation

class StoreModel {
    // 내부 경로 참조 방법
    let jsonFilePath = Bundle.main.path(forResource: "main", ofType: "json")
    lazy var mainJsonData = try? Data.init(contentsOf: URL(fileURLWithPath: jsonFilePath!, isDirectory: false))
    lazy var mainJson = try JSONSerialization.jsonObject(with: mainJsonData!, options: [])
    // StoreItem 구조체
    struct StoreItem : Decodable{
        var image : String
        var title : String
        var description : String
        var s_price : String
        var badge : [String]?   // 배열, 값이 없을수도 있음
    }
    
    //json decode 함수
    func decodeJsonToStoreItemArray()->Array<StoreItem>{
        var storeItemArray : Array<StoreItem> = []
        let decoder = JSONDecoder()
        do{
            try storeItemArray = decoder.decode(Array<StoreItem>.self, from: mainJsonData!)
        }catch let error{
            print(error)
        }
        return storeItemArray
    }
}

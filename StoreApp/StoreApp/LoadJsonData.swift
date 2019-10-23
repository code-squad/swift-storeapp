//
//  LoadJsonData.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/23.
//  Copyright © 2019 hong3. All rights reserved.
//

import Foundation

func loadItem() {
    let f_path = Bundle.main.path(forResource: "main", ofType: "json")!
    let data = try! Data(contentsOf:URL(fileURLWithPath: f_path),options: .mappedIfSafe)
    let store_item = try? JSONDecoder().decode([StoreItem].self,from:data)
    print(store_item)
}

//
//  test_code.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/23.
//  Copyright © 2019 hong3. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()
let path = Bundle.main.url(forResource: "main", withExtension: "json")!
let data_init = try! Data.init(contentsOf: path)
let json_decoder = JSONDecoder()
let store_item = try! json_decoder.decode(StoreItem.self,from:data_init)
print(

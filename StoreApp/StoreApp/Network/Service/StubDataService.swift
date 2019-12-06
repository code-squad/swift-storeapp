//
//  StubService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation

struct StubService: DataServable {
    
    func fetchData<E>(_ endPoint: E, completion: @escaping () -> Void) where E : EndPoint {
        Dummy.storeData
    }
}

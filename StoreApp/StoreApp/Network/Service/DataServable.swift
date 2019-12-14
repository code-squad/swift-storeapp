//
//  DataServeable.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation


protocol DataServable {
    
    func fetchData(completion: @escaping (Result<[Store], Error>) -> Void)
}

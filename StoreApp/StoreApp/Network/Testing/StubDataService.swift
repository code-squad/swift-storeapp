//
//  StubService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation

struct StubDataService: DataServable {
    
    private let sampleData = Dummy.storeData
    
    func fetchData<E: EndPoint, D: Decodable>(_ endPoint: E,
                                              completion: @escaping (Result<D, Error>) -> Void)  {
        do {
            let decodable = try JSONDecoder().decode(D.self, from: sampleData)
            completion(.success(decodable))
        } catch let error {
            completion(.failure(error))
        }
    }
}

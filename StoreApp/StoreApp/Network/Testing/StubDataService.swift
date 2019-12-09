//
//  StubService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation

struct StubDataService: DataServable {
    
    
    func fetchData<E: EndPoint, D: Decodable>(_ endPoint: E,
                                              completion: @escaping (Result<D, Error>) -> Void)  {
        
        guard let data = endPoint.sampleData else { return }
        
        do {
            let decodable = try JSONDecoder().decode(D.self, from: data)
            completion(.success(decodable))
        } catch let error {
            completion(.failure(error))
        }
    }
}

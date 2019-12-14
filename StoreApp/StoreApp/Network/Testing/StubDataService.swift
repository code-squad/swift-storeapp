//
//  StubService.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation

struct StubDataService: DataServable {
    
    let dispatchGroup = DispatchGroup()
    let serialQueue = DispatchQueue(label: "store.fetch", qos: .default)
    
    func fetchData(completion: @escaping (Result<[Store], Error>) -> Void) {
        var stores: [Store] = []
        
        fetchData(endPoint: DummyAPI.main) { result in
            switch result {
            case .success(let menus):
                let store = Store(category: .main, menus: menus)
                stores.append(store)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        fetchData(endPoint: DummyAPI.soup) { result in
            switch result {
            case .success(let menus):
                let store = Store(category: .soup, menus: menus)
                stores.append(store)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        fetchData(endPoint: DummyAPI.side) { result in
            switch result {
            case .success(let menus):
                let store = Store(category: .side, menus: menus)
                stores.append(store)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        dispatchGroup.notify(queue: .global()) {
            completion(.success(stores))
        }
    }
    
    private func fetchData(endPoint: EndPoint,
                           completion: @escaping (Result<[Menu], Error>) -> Void) {
        
        serialQueue.async(group: dispatchGroup) {
            guard let data = endPoint.sampleData else { return }
            
            do {
                let menus = try JSONDecoder().decode([Menu].self, from: data)
                completion(.success(menus))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
}

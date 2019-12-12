//
//  StoreListVIewModel.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit


typealias Store = (category: Category, menus: [Menu])

final class StoreListViewModel: StoreListViewBindable {
    
    // MARK: - Dependencies
    
    private let service: DataServable
    
    // MARK: - Properties
    
    private var stores: [Store] = []
    
    // MARK: - Status Closure
    
    var dataDidLoad: (() -> Void)?
    var dataDidUpadated: (() -> Void)?
    var errorDidOccured: ((Error) -> Void)?
    
    // MARK: - Initializer
    
    init(service: DataServable) {
        self.service = service
        fetchData()
    }
    
    // MARK: - Methods
    
    func numOfCategories() -> Int {
        return stores.count
    }
    
    func numOfMenusInCategory(_ category: Int) -> Int {
        return stores[category].menus.count
    }
    
    // MARK: - Subscripts
    
    subscript(category index: Int) -> Category {
        let store = stores[index]
        return store.category
    }
    
    subscript(menu indexPath: IndexPath) -> Menu {
        let store = stores[indexPath.section]
        return store.menus[indexPath.row]
    }
}

// MARK: - Fetch

extension StoreListViewModel {
    
    private func fetchData() {
        service.fetchData(DummyAPI.main) {
            [weak self] (result: Result<[Menu], Error>)  in
            switch result {
            case .success(let menus):
                self?.stores.append(Store(category: .main, menus: menus))
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
        
        service.fetchData(DummyAPI.soup) {
            [weak self] (result: Result<[Menu], Error>)  in
            switch result {
            case .success(let menus):
                self?.stores.append(Store(category: .soup, menus: menus))
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
        
        service.fetchData(DummyAPI.side) {
            [weak self] (result: Result<[Menu], Error>)  in
            switch result {
            case .success(let menus):
                self?.stores.append(Store(category: .side, menus: menus))
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
    }
}

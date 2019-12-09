//
//  StoreListVIewModel.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit


typealias Store = (title: String, menus: [Menu])

final class StoreListViewModel: StoreListViewBindable {
    
    // MARK: - Dependencies
    
    private let service: DataServable
    
    // MARK: - Properties
    
    private var stores: [Store] = []
    
    // MARK: - Status Closure
    
    var dataDidLoad: (() -> Void)?
    var dataDidUpadated: (() -> Void)?
    
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
    
    subscript(category index: Int) -> String {
        let store = stores[index]
        return store.title
    }
    
    subscript(menu indexPath: IndexPath) -> Menu {
        let store = stores[indexPath.section]
        return store.menus[indexPath.row]
    }
    
}

// MARK: - Fetch

extension StoreListViewModel {
    
    private func fetchData() {
        service.fetchData(Dummy.endPoint) {
            [weak self] (result: Result<[Menu], Error>)  in
            switch result {
            case .success(let menus):
                self?.stores.append(Store(title: "타이틀", menus: menus))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

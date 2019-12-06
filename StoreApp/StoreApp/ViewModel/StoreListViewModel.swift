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

protocol StoreListViewBindable: AnyObject {
    
    var dataDidLoad: (() -> Void)? { get set }
    var dataDidUpadated: (() -> Void)? { get set }
    
    func numOfCategories() -> Int
    func numOfMenusInCategory(_ category: Int) -> Int
    
    subscript(category index: Int) -> String { get }
    subscript(menu indexPath: IndexPath) -> Menu { get }
}

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

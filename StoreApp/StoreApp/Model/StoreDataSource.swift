//
//  StoreDataSource.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 30..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import Foundation

struct StoreDataSource {
    private var items: [[StoreItem]]

    init() {
        items = [[StoreItem]]()
    }

    mutating func setItems(resources: [String]) throws {
        let section = resources.count
        for s in 0..<section {
            do {
                let item = try decodeJSONData(from: resources[s])
                items[section].append(contentsOf: item)
            } catch let error {
                throw error
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return items[section].count
    }

    func item(indexPath: IndexPath) -> StoreItem {
        return items[indexPath.section][indexPath.row]
    }

    private func decodeJSONData(from resourceName: String) throws -> [StoreItem] {
        do {
            let data = try DataManager.getJSONDataFromURL(resourceName)
            let items = try JSONDecoder().decode([StoreItem].self, from: data)
            return items
        } catch let error {
            throw error
        }
    }
}

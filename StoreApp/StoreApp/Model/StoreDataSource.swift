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
        let sectionCount = resources.count
        items = [[StoreItem]](repeating: [], count: sectionCount)
        for s in 0..<sectionCount {
            do {
                let item = try decodeJSONData(from: resources[s])
                items[s].append(contentsOf: item)
            } catch let error {
                throw error
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if items.isEmpty { return 0 }
        return items[section].count
    }

    func item(indexPath: IndexPath) -> StoreItem? {
        if items.isEmpty { return nil }
        return items[indexPath.section][indexPath.row]
    }

    func description(indexPath: IndexPath) -> String? {
        let newline = "\n"
        let i = item(indexPath: indexPath)
        guard let title = i?.title,
            let price = i?.s_price.priceString else { return nil }
        return title+newline+price
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

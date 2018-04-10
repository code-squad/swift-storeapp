//
//  StoreItems.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class StoreItems {
    private(set) var sectionHeaders = [(section: String, title: String, description: String)]()
    private var sections = [String: [StoreItem]]()

    subscript(index: Int) -> [StoreItem] {
        guard index < sections.count else { return [] }
        return sections[sectionHeaders[index].section] ?? []
    }

    func count(of index: Int) -> Int {
        guard let section = sections[sectionHeaders[index].section] else { return 0 }
        return section.count
    }

    func setStoreData(with sections: [Keyword.Section]) {
        sections.forEach { setJSONData(with: $0) }
    }

    private func setJSONData(with section: Keyword.Section) {
        guard let url = URL(string: section.url) else { return }
        let urlSession = URLSession.shared
        setHeaders(of: section)
        urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                self.setStoreItems(with: data, to: section)
                NotificationCenter.default.post(name: section.notification, object: self)
            }
        }).resume()
    }

    private func setHeaders(of section: Keyword.Section) {
        let header = section.description.split(separator: "/").map { String($0.trimmingCharacters(in: [" "])) }
        sectionHeaders.append((section: section.value, title: header[0], description: header[1]))
    }

    private func setStoreItems(with data: Data, to section: Keyword.Section) {
        let storeItems = self.convert(from: data)
        sections[section.value] = storeItems
    }

    private func convert(from data: Data) -> [StoreItem] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([StoreItem].self, from: data)
        } catch {
            return []
        }
    }

}


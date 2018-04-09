//
//  StoreItems.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class StoreItems {
    private(set) var sectionHeaders = [(title: String, description: String)]()
    private var sections = [[StoreItem]]()

    subscript(index: Int) -> [StoreItem] {
        guard index < sections.count else { return [] }
        return sections[index]
    }

    func count(of index: Int) -> Int {
        return sections[index].count
    }

    func setStoreData(with files: [Keyword.File]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            files.forEach { self?.setJSONData(with: $0) }
            NotificationCenter.default.post(name: .storeItems, object: self)
        }

    }

    private func setJSONData(with fileName: Keyword.File) {
        guard let data = self.getData(from: fileName.value) else { return }
        let storeItems = self.convert(from: data)
        sections.append(storeItems)
        let header = fileName.sectionName.split(separator: "/").map { String($0.trimmingCharacters(in: [" "])) }
        sectionHeaders.append((title: header[0], description: header[1]))
    }

    private func getData(from jsonFile: String) -> Data? {
        let path = Bundle.main.path(forResource: jsonFile, ofType: Keyword.File.ext.value)
        let url = URL(fileURLWithPath: path!)
        return try? Data(contentsOf: url)
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


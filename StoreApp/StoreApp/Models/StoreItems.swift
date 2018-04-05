//
//  StoreItems.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class StoreItems {
    private var storeItems = [StoreItem]()

    subscript(index: Int) -> StoreItem? {
        guard index < storeItems.count else { return nil }
        return storeItems[index]
    }

    var count: Int {
        return storeItems.count
    }

    func setJSONData(with fileName: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = self?.getData(from: fileName) else { return }
            guard let storeItems = self?.convert(from: data) else { return }
            self?.storeItems = storeItems
            NotificationCenter.default.post(name: .storeItems, object: self)
        }
    }

    private func getData(from jsonFile: String) -> Data? {
        let path = Bundle.main.path(forResource: jsonFile, ofType: Keyword.fileExtension.value)
        let url = URL(fileURLWithPath: path!)
        return try? Data(contentsOf: url)
    }

    private func convert(from data: Data) -> [StoreItem] {
        do {
            return try JSONDecoder().decode([StoreItem].self, from: data)
        } catch {
            return []
        }
    }

}


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

    func setHeaders(with headers: [Keyword.Section]) {
        headers.forEach { setHeader(of: $0) }
    }

    func setStoreData(with sections: [Keyword.Section]) {
        sections.forEach { setJSONData(with: $0) }
    }

    private func setJSONData(with section: Keyword.Section) {
        guard let url = URL(string: section.url) else { return }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.setStoreItems(with: data, to: section)
                    let indexPaths = Array(0..<(self.sections[section.value]?.count)!)
                                     .map {IndexPath(row: $0, section: self.getIndex(of: section))}
                    indexPaths.forEach { self.downloadImages(on: $0) }
                    NotificationCenter.default.post(name: .storeItems, object: self,
                                                    userInfo: ["indexPaths": indexPaths])
                }
            }
        }).resume()
    }

    private func getIndex(of section: Keyword.Section) -> Int {
        for index in sectionHeaders.indices where sectionHeaders[index].section == section.value { return index }
        return 0
    }

    private func setHeader(of section: Keyword.Section) {
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

    private func downloadImages(on indexPath: IndexPath) {
        guard let items = sections[sectionHeaders[indexPath.section].section] else { return }
        let item = items[indexPath.row]
        guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        guard let imageUrl = URL(string: item.image) else { return }
        let fileURL = cacheURL.appendingPathComponent(imageUrl.lastPathComponent)
        guard FileManager.default.fileExists (atPath: fileURL.path) else {
            URLSession.shared.downloadTask(with: imageUrl, completionHandler: { (url, urlResponse, error) in
                if let url = url {
                    try? FileManager.default.moveItem(at: url, to: fileURL)
                    self.notifyImage(fileURL: fileURL, indexPath: indexPath)
                }
            }).resume()
            return
        }
        notifyImage(fileURL: fileURL, indexPath: indexPath)
    }

    private func notifyImage(fileURL: URL, indexPath: IndexPath) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .image,
                                            object: self,
                                            userInfo: ["image": fileURL, "indexPath": indexPath])
        }
    }

}


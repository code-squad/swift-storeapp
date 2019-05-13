//
//  StoreItems.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import JSONDataFetcher

class StoreItems {
    
    //MARK: - Properties
    //MARK: Models
    let sectionInfo: SectionInfo
    private var storeItems = [StoreItem]()
    
    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItem? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init(storeItemsInitInfo: SectionInfo) {
        self.sectionInfo = storeItemsInitInfo
        let fetcher = JSONDataFetcher()
        let completion: ([StoreItem]) -> Void = { storeItems in
            let appendItems = { () -> Void in
                self.storeItems.append(contentsOf: storeItems)
            }
            let userInfo = [UserInfoKey.appendItems: appendItems]
            NotificationCenter.default.post(name: .storeItemsWillUpdate, object: self, userInfo: userInfo)
        }
        fetcher.fetchStoreItems(fileName: storeItemsInitInfo.fileName, completion: completion)
    }
    
    //MARK: Instance
    func count() -> Int {
        return storeItems.count
    }
    
    func postReloadRow(section: Int, imageName: String) {
        for (index, item) in storeItems.enumerated() {
            guard item.image.lastPathComponent() == imageName else { continue }
            let userInfo = [UserInfoKey.indexPathWillReload: IndexPath(row: index,
                                                                       section: section)]
            NotificationCenter.default.post(name: .rowWillReload,
                                            object: nil,
                                            userInfo: userInfo)
        }
    }
}

extension JSONDataFetcher {
    func fetchStoreItems(fileName: String, completion: @escaping ([StoreItem]) -> Void) {
        let commonURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
        guard let url = URL(string: commonURL + fileName) else { return }
        load(url: url) { (data) in
            let decoder = JSONDecoder()
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let data = try? JSONSerialization.data(withJSONObject: json["body"], options: []),
                let items = try? decoder.decode([StoreItem].self, from: data) else { return }
            items.downloadImages()
            completion(items)
        }
    }
    
    func downloadImage(with url: URL) {
        URLSession.shared.downloadTask(with: url) { (fileURL, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let fileURL = fileURL,
                let response = response as? HTTPURLResponse,
                (200...299) ~= response.statusCode,
                let cacheURL = URL.cachesDirectory() else { return }
            
            let savedURL = cacheURL.appendingPathComponent(url.lastPathComponent)
            try? FileManager.default.moveItem(at: fileURL, to: savedURL)
            
            let userInfo = [UserInfoKey.imageName: url.lastPathComponent]
            NotificationCenter.default.post(name: .imageDidDownload,
                                            object: nil,
                                            userInfo: userInfo)
            
            }.resume()
    }
}

extension Array where Element == StoreItem {
    func downloadImages() {
        for item in self {
            let image = item.image
            guard let imageURL = URL(string: image),
                let cacheURL = URL.cachesDirectory() else { return }
            let imagePath = cacheURL.appendingPathComponent(image.lastPathComponent())
            guard FileManager.default.fileExists(atPath: imagePath.path) == false else { return }
            let jsonFetcher = JSONDataFetcher()
            jsonFetcher.downloadImage(with: imageURL)
        }
    }
}

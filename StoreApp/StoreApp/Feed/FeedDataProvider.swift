//
//  FeedDataProvider.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/16.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

struct FeedDataProvider {
    func request(assets: [StoreItemCategory], completion: @escaping (Result<[FeedSection], FeedError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        var feedSections: [FeedSection] = []
        
        DispatchQueue.global().async {
            assets.forEach { asset in
                guard let dataAsset = NSDataAsset(name: asset.rawValue) else {
                    completion(.failure(.missingAsset(assetName: asset.rawValue)))
                    return
                }
                do {
                    let storeItems = try jsonDecoder.decode([StoreItem].self, from: dataAsset.data)
                    feedSections.append(FeedSection(category: asset, storeItems: storeItems))
                } catch let error {
                    completion(.failure(.decodingFailed(error: error)))
                }
            }
            completion(.success(feedSections))
        }
    }
}

//
//  ImageCacheManager.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class CacheStorage {
    let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first

    func getData(from url: String) -> Data? {

    }

    func setData(_ data: Data, key: URLResourceKey) {
        let resourceValues = URLResourceValues.init()

        cacheDirectory?.setResourceValues()
    }

    func loadImage() {

    }
}

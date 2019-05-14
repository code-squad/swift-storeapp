//
//  ImageURL.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 14..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import JSONDataFetcher

struct ImageURL {
    let url: URL
    
    func downloadImage() {
        guard let cacheURL = URL.cachesDirectory() else { return }
        let imagePath = cacheURL.appendingPathComponent(url.lastPathComponent)
        guard FileManager.default.fileExists(atPath: imagePath.path) == false else { return }
        let jsonFetcher = JSONDataFetcher()
        jsonFetcher.downloadImage(with: url)
    }
}

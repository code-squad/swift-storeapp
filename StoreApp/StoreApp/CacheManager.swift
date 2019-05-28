//
//  CacheManager.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct CacheManager {
    func cachingImage(with url: URL) {
        guard let cacheURL = URL.cachesDirectory() else { return }
        let imagePath = cacheURL.appendingPathComponent(url.lastPathComponent)
        guard FileManager.default.fileExists(atPath: imagePath.path) == false else { return }
        let downloader = Downloader()
        let downloadImage = { (fileURL: URL) -> Void in
            try? FileManager.default.moveItem(at: fileURL, to: imagePath)
            let userInfo = [UserInfoKey.imageName: url.lastPathComponent]
            NotificationCenter.default.post(name: .imageDidDownload,
                                            object: nil,
                                            userInfo: userInfo)
        }
        downloader.download(with: url, successHandler: downloadImage)
    }
}

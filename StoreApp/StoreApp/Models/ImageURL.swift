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
        let downloadImage = { (fileURL: URL) -> Void in
            try? FileManager.default.moveItem(at: fileURL, to: imagePath)
            let userInfo = [UserInfoKey.imageName: self.url.lastPathComponent]
            NotificationCenter.default.post(name: .imageDidDownload,
                                            object: nil,
                                            userInfo: userInfo)
        }
        jsonFetcher.download(with: url, successHandler: downloadImage)
    }
}

extension JSONDataFetcher {
    func download(with url: URL, successHandler: @escaping (URL) -> Void) {
        URLSession.shared.downloadTask(with: url) { (fileURL, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let fileURL = fileURL,
                let response = response as? HTTPURLResponse,
                (200...299) ~= response.statusCode,
                let cacheURL = URL.cachesDirectory() else { return }
            
            successHandler(fileURL)
            
            }.resume()
    }
}

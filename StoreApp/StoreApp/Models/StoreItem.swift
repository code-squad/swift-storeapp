//
//  StoreItem.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import JSONDataFetcher

struct StoreItem: Decodable {
    let detail_hash: String
    let image: String
    let alt: String
    let delivery_type: [String]
    let title: String
    let description: String
    let n_price: String?
    let s_price: String
    let badge: [String]?
    
    func downloadImage() {
        guard let imageURL = URL(string: image),
            let cacheURL = URL.cachesDirectory() else { return }
        let imagePath = cacheURL.appendingPathComponent(image.lastPathComponent())
        guard FileManager.default.fileExists(atPath: imagePath.path) == false else { return }
        let jsonFetcher = JSONDataFetcher()
        jsonFetcher.downloadImage(with: imageURL)
    }
}

extension JSONDataFetcher {
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

extension String {
    func lastPathComponent() -> String {
        return NSString(string: self).lastPathComponent
    }
}

extension URL {
    static func cachesDirectory() -> URL? {
        let cacheURL = try? FileManager.default.url(for: .cachesDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: false)
        return cacheURL
    }
}

extension NSNotification.Name {
    static let imageDidDownload = NSNotification.Name("imageDidDownload")
}

extension UserInfoKey {
    static let imageName = "imageName"
}

//
//  ImageSetter.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 25..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ImageSetter {
    static let fileManager = FileManager.default

    class func tryDownload(url: String, handler: @escaping ((Data?) -> Void)) {
        let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let imageSavingPath = cacheURL.appendingPathComponent(URL(string: url)!.lastPathComponent)

        if NetworkManager.shared.reachable {
            ImageSetter.download(url: url, handler: handler)
        } else {
            print("Not Reachable - ImageSetter")
            // cache에서
            let imageData = cacheImageData(at: imageSavingPath)
            handler(imageData)
        }
    }

    private class func download(url: String, handler: @escaping((Data?) -> Void)) {
        let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let imageSavingPath = cacheURL.appendingPathComponent(URL(string: url)!.lastPathComponent)

        if let imageData = cacheImageData(at: imageSavingPath) {
            handler(imageData) // 네트워크에러일때 cache에서 이미지 가져옴 
        } else {
            URLSession.shared.downloadTask(with: URL(string: url)!) { (tmpLocation, response, error) in
                if let error = error {
                    let imageData = cacheImageData(at: imageSavingPath)
                    handler(imageData)
                }
                if let response = response as? HTTPURLResponse, response.statusCode == 200, let tmpLocation = tmpLocation {
                    do {
                        try fileManager.moveItem(at: tmpLocation, to: imageSavingPath)
                        if let imageData = try? Data(contentsOf: imageSavingPath) {
                            handler(imageData)
                        } else {
                            let imageData = cacheImageData(at: imageSavingPath)
                            handler(imageData)
                        }
                    } catch {
                        let imageData = cacheImageData(at: imageSavingPath)
                        handler(imageData)
                    }
                }
            }.resume()
        }
    }

    class func cacheImageData(at imageSavingPath: URL) -> Data? {
        guard FileManager().fileExists(atPath: imageSavingPath.path) else { return nil }
            let existData = try? Data(contentsOf: imageSavingPath)
            return existData
    }

    class func downloadDetailImages(urls: [String], completion: Notification.Name) {
        var imgData = [Data?]()
        urls.forEach { imageURL in
            ImageSetter.tryDownload(url: imageURL, handler: { imageData in
                DispatchQueue.main.async {
                    imgData.append(imageData)
                    if imgData.count == urls.count {
                        NotificationCenter.default.post(name: completion, object: self, userInfo: [completion:imgData])
                    }
                }
            })
        }
    }
}

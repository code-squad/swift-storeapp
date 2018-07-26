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

    class func download(with url: String, handler: @escaping((Data) -> Void)) {
        let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let imageSavingPath = cacheURL.appendingPathComponent(URL(string: url)!.lastPathComponent)

        if let imageData = existFile(at: imageSavingPath) {
            handler(imageData)
        } else {
            URLSession.shared.downloadTask(with: URL(string: url)!) { (tmpLocation, response, error) in
                if let error = error {
                    print("Image download Error log: \(error)\n")
                }
                if let response = response as? HTTPURLResponse, response.statusCode == 200, let tmpLocation = tmpLocation {
                    do {
                        try fileManager.moveItem(at: tmpLocation, to: imageSavingPath)
                        if let imageData = try? Data(contentsOf: imageSavingPath) {
                            handler(imageData)
                        } else {
                            print("MOVE Error!")
                        }
                    } catch { print("MOVE Error!") }
                }
            }.resume()
        }
    }

    class func existFile(at imageSavingPath: URL) -> Data? {
        guard FileManager().fileExists(atPath: imageSavingPath.path) else { return nil }
            let existData = try? Data(contentsOf: imageSavingPath)
            return existData
    }
}

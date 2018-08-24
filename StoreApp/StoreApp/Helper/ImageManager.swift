//
//  ImageManager.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 24..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation
import Toaster

struct ImageManager {
    
    static let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    
    static func imagePath(string url: String) -> String {
        guard let imageURL = URL(string: url)?.lastPathComponent else { return "" }
        return cacheURL.appendingPathComponent(imageURL).path
    }
    
    static func downloadThumbnailImages(from urls: [String]) {
        let downloadSession = URLSession(configuration: .default)
        let imageURLs = urls.compactMap { URL(string: $0) }
        
        imageURLs.forEach { imageURL in
            let saveURL = cacheURL.appendingPathComponent(imageURL.lastPathComponent)
            if FileManager.default.fileExists(atPath: saveURL.path) { return }
            StoreAPI.downloadThumbnailImage(imageURL: imageURL, session: downloadSession) { (tempURL, error) in
                if error != nil {
                    ToastCenter.default.cancelAll()
                    Toast(text: "Image Download Fail.").show()
                    return
                }
                do {
                    guard let tempURL = tempURL else { return }
                    try FileManager.default.moveItem(at: tempURL, to: saveURL)
                } catch let error {
                    Toast(text: "Can't copy image to cache directory : \(error)").show()
                    return
                }
            }
        }
    }
}

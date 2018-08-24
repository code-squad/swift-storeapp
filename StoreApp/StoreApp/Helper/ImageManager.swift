//
//  ImageManager.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 24..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct ImageManager {
    
    fileprivate static let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    
    static func imagePath(string url: String) -> String {
        guard let imageURL = URL(string: url)?.lastPathComponent else { return "" }
        return cacheURL.appendingPathComponent(imageURL).path
    }
    
    static func downloadThumbnailImages(from urls: [String]) {
        let downloadSession = URLSession(configuration: .default)
        let imageURLs = urls.compactMap { URL(string: $0) }
        tryDownloadImages(session: downloadSession, imageURLs)
    }
    
    fileprivate static func tryDownloadImages(session: URLSession, _ imageURLs: [URL]) {
        imageURLs.forEach {
            let saveURL = cacheURL.appendingPathComponent($0.lastPathComponent)
            if FileManager.default.fileExists(atPath: saveURL.path) { return }
            downloadImage(session: session, imageURL: $0, saveURL: saveURL)
        }
    }
    
    fileprivate static func downloadImage(session: URLSession, imageURL: URL, saveURL: URL) {
        StoreAPI.downloadThumbnailImage(imageURL: imageURL, session: session) { (tempURL, error) in
            guard error == nil else { return }
            guard let tempURL = tempURL else { return }
            try? FileManager.default.moveItem(at: tempURL, to: saveURL)
        }
    }
}

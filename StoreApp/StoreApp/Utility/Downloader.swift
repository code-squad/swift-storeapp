//
//  Downloader.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 23..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

class Downloader {
    
    static func generateFileURL (_ imageURL: String) -> URL? {
        guard let documentDirectoryPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        guard let imageURL = URL(string: imageURL) else { return nil }
        return documentDirectoryPath.appendingPathComponent(imageURL.lastPathComponent)
    }
    
    static func isExistantFileAt(_ fileURL: URL) -> Bool {
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    static func loadData(_ fileURL: URL) -> Data? {
        return FileManager.default.contents(atPath: fileURL.path)
    }
    
    static func savdData(_ menuImageURL: String, _ fileURL: URL) -> Data? {
        guard let imageURL = URL(string: menuImageURL) else { return nil }
        guard let data = try? Data(contentsOf: imageURL) else { return nil }
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        return data
    }
    
}

//
//  ImageCacheManager.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class CacheStorage {
    static let cacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    static func retrieve(_ fileName: String) -> Data? {
        guard FileManager.default.fileExists(atPath: cacheUrl.path) else { return nil }
        let fileUrl = cacheUrl.appendingPathComponent(fileName)
        return FileManager.default.contents(atPath: fileUrl.path)
    }

    static func save(_ fileName: String, _ data: Data?) throws {
        let fileUrl = cacheUrl.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            try FileManager.default.removeItem(at: fileUrl)
        }
        FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: nil)
    }

    static func reset() throws {
        let contents = try FileManager.default.contentsOfDirectory(atPath: cacheUrl.path)
        for contentPath in contents {
            try FileManager.default.removeItem(atPath: contentPath)
        }
    }

}

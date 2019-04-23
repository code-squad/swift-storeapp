//
//  FileURL.swift
//  StoreApp
//
//  Created by 윤동민 on 15/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct FileName {
    static let mainItem = "main.json"
    static let soupItem = "soup.json"
    static let sideItem = "side.json"
    
    static func getFileName(from fullPath: String) -> String {
        guard let fileName = URL(string: fullPath) else { return "" }
        return fileName.lastPathComponent
    }
    
    static func makeFullPath(with fileName: String) -> URL? {
        var cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        cachePath?.appendPathComponent(fileName)
        return cachePath
    }
}

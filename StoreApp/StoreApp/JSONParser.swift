//
//  JSONParser.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct JSONParser {
    static func getText(from url: String) -> String? {
        guard let url = URL(string: url) else { return nil }
        return try? String(contentsOf: url, encoding: .utf8)
    }
    
    static func getTextFrom(file: String) -> String? {
        var fileURL = URL(fileURLWithPath: FileURL.projectFolderURL)
        fileURL.appendPathComponent(file)
        return try? String(contentsOf: fileURL, encoding: .utf8)
    }
    
    static func parseJSONData(from jsonData: String) -> [StoreItem]? {
        let jsonDecoder = JSONDecoder()
        guard let data = jsonData.data(using: .utf8) else { return nil }
        return try? jsonDecoder.decode(Array<StoreItem>.self, from: data)
    }
}

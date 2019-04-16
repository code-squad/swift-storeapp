//
//  FileReader.swift
//  StoreApp
//
//  Created by 윤동민 on 16/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct FileReader {
    static func getTextFrom(file: String) -> String? {
        guard let filePath = searchPathFromBundle(of: file) else { return nil }
        return try? String(contentsOfFile: filePath, encoding: .utf8)
    }
    
    static func searchPathFromBundle(of file: String) -> String? {
        let fileNameAndExtension = file.split(separator: ".").map { String.init($0) }
        guard fileNameAndExtension.count == 2 else { return nil }
        return Bundle.main.path(forResource: fileNameAndExtension[0], ofType: fileNameAndExtension[1])
    }
}
